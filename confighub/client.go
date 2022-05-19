package confighub

import (
	"bytes"
	"encoding/json"
	"fmt"
	"io/ioutil"
	"log"
	"math"
	"net/http"
	"net/url"
	"time"

	"github.com/hashicorp/terraform-plugin-sdk/v2/helper/schema"
)

var UrlBase *string
var HttpClient *http.Client

type Client struct {
	ProviderData *ProviderData
	BaseUrl      *url.URL
	httpClient   *http.Client
}

// NewClient initializes a new Client instance to communicate with the CMDB api
func NewClient(providerData *ProviderData) *Client {
	client := &Client{ProviderData: providerData}

	client.httpClient = &http.Client{
		Timeout: time.Second * 30,
	}

	urlstr := ""
	if providerData.Port == 0 {
		urlstr = providerData.Hostname
	} else {
		urlstr = fmt.Sprintf("%s://%s:%d", providerData.Scheme, providerData.Hostname, providerData.Port)
	}

	if u, err := url.Parse(urlstr); err != nil {
		panic("Could not init Provider client to ConfigHub")
	} else {
		client.BaseUrl = u
	}

	return client
}

func (c *Client) constructFullUrl(path string, repoInfo RepoInfo) string {
	url := ""
	account := c.ProviderData.DefaultAccount
	if repoInfo.Account != "" {
		account = repoInfo.Account
	}
	repository := c.ProviderData.DefaultRepository
	if repoInfo.Repository != "" {
		repository = repoInfo.Repository
	}
	if account != "" && repository != "" {
		url = fmt.Sprintf("%s%s/%s/%s", c.BaseUrl, path, account, repository)
	} else {
		url = fmt.Sprintf("%s%s", c.BaseUrl, path)
	}
	return url
}

func (c *Client) getRepoInfo(d *schema.ResourceData) RepoInfo {
	return RepoInfo{
		Account:     d.Get("account").(string),
		Repository:  d.Get("repository").(string),
		ClientToken: d.Get("client_token").(string),
	}
}

func (c *Client) populateHeaders(headers http.Header, clientToken string) {
	headers.Set("Content-Type", "application/json")
	headers.Set("Accept", "application/json")
	if c.ProviderData.ClientVersion != "" {
		headers.Set("Client-Version", c.ProviderData.ClientVersion)
	}
	if clientToken != "" {
		headers.Set("Client-Token", clientToken)
	} else if c.ProviderData.DefaultClientToken != "" {
		headers.Set("Client-Token", c.ProviderData.DefaultClientToken)
	}
}

func (c *Client) doHttpRequestWithRetry(req *http.Request, requestBody []byte, requestName string) (*http.Response, error) {
	var resp *http.Response
	var err error

	for retry := 0; retry < 8 && (resp == nil || resp.StatusCode == 304); retry++ {
		headers := req.Header.Clone()
		req, err = http.NewRequest(req.Method, req.URL.String(), bytes.NewBuffer(requestBody))
		req.Header = headers

		if err != nil {
			return nil, err
		}
		resp, err = c.httpClient.Do(req)
		if err != nil {
			return nil, fmt.Errorf("unable to issue %s: %s", requestName, err.Error())
		}

		_, err = ioutil.ReadAll(resp.Body)
		if err != nil {
			return nil, fmt.Errorf("cannot parse response from %s: %s", requestName, err.Error())
		}
		defer resp.Body.Close()
		time.Sleep(time.Duration(math.Pow(2, float64(retry)+1)) * time.Second)
	}

	return resp, err
}

type RepoInfo struct {
	Account     string
	Repository  string
	ClientToken string
}

type PullConfigPropertiesInput struct {
	Context         string
	ApplicationName string
	Tag             string
	RepositoryDate  string
	RepoInfo        RepoInfo
}

// HTTP GET - /rest/pull
func (c *Client) doPullConfigProperties(input PullConfigPropertiesInput) (objmap map[string]interface{}, err error) {
	url := c.constructFullUrl("/rest/pull", input.RepoInfo)
	req, err := http.NewRequest(http.MethodGet, url, nil)
	if err != nil {
		return nil, err
	}
	c.populateHeaders(req.Header, input.RepoInfo.ClientToken)
	req.Header.Add("Context", input.Context)
	req.Header.Add("No-Files", "true")
	if input.ApplicationName != "" {
		req.Header.Add("Application-Name", input.ApplicationName)
	}
	if input.Tag != "" {
		req.Header.Add("Tag", input.Tag)
	}
	if input.RepositoryDate != "" {
		req.Header.Add("Repository-Date", input.RepositoryDate)
	}

	log.Printf("Calling %s\n", req.URL.String())

	resp, err := c.httpClient.Do(req)
	if err != nil {
		return nil, fmt.Errorf("unable to issue config pull request: %s", err.Error())
	}
	if resp.Header.Get("Content-Type") != "application/json" {
		return nil, fmt.Errorf("Content-Type of HTTP response is invalid")
	}

	body, err := ioutil.ReadAll(resp.Body)
	if err != nil {
		return nil, fmt.Errorf("cannot parse response from name allocation API: %s", err.Error())
	}
	defer resp.Body.Close()

	if resp.StatusCode != 200 && resp.StatusCode != 304 {
		return nil, fmt.Errorf("name allocation API returned HTTP status code %d", resp.StatusCode)
	} else if resp.StatusCode == 304 {
		properties := make([]interface{}, 0)
		objmap = map[string]interface{}{
			"properties": properties,
		}
		return
	}

	log.Printf("Raw output: %v\n", string(body))

	err = json.Unmarshal(body, &objmap)
	if err != nil {
		log.Fatal(err)
	}

	return
}

type PullConfigFileInput struct {
	FilePath        string
	Context         string
	ApplicationName string
	Tag             string
	RepositoryDate  string
	RepoInfo        RepoInfo
}

func (c *Client) doPullConfigFile(input PullConfigFileInput) (fileContent string, err error) {
	url := c.constructFullUrl("/rest/rawFile", input.RepoInfo)
	req, err := http.NewRequest(http.MethodGet, url, nil)
	if err != nil {
		return "", err
	}
	c.populateHeaders(req.Header, input.RepoInfo.ClientToken)
	req.Header.Add("File", input.FilePath)
	req.Header.Add("Context", input.Context)

	log.Printf("Calling %s\n", req.URL.String())

	resp, err := c.httpClient.Do(req)
	if err != nil {
		return "", fmt.Errorf("unable to issue config pull request: %s", err.Error())
	}

	body, err := ioutil.ReadAll(resp.Body)
	if err != nil {
		return "", fmt.Errorf("cannot parse response from name allocation API: %s", err.Error())
	}
	defer resp.Body.Close()

	if resp.StatusCode != 200 && resp.StatusCode != 204 {
		return "", fmt.Errorf("property pull request returned HTTP status code %d: %s", resp.StatusCode, resp.Header.Get("Etag"))
	}

	if resp.StatusCode == 204 {
		return "", nil
	}

	fileContent = string(body)

	log.Printf("Raw output: %v\n", fileContent)

	return
}

type PushConfigPropertyValue struct {
	Context string `json:"context"`
	Value   string `json:"value"`
	Active  bool   `json:"active"`
}

type PushConfigProperty struct {
	Key           string                    `json:"key"`
	Readme        string                    `json:"readme"`
	Deprecated    bool                      `json:"deprecated"`
	Vdt           string                    `json:"vdt"`
	Push          bool                      `json:"push"`
	SecurityGroup string                    `json:"securityGroup"`
	Password      string                    `json:"password"`
	Values        []PushConfigPropertyValue `json:"values"`
}

type PushConfigRequest struct {
	ChangeComment     string        `json:"changeComment"`
	EnableKeyCreation bool          `json:"enableKeyCreation"`
	Data              []interface{} `json:"data"`
}

type PushConfigPropertyInput struct {
	PushConfigProperty PushConfigProperty
	RepoInfo           RepoInfo
}

// HTTP POST - /rest/push
func (c *Client) doPushConfigProperty(input PushConfigPropertyInput) (sucess bool, err error) {
	url := c.constructFullUrl("/rest/push", input.RepoInfo)
	pushConfigRequest := PushConfigRequest{
		ChangeComment:     "Managed by Terraform",
		EnableKeyCreation: true,
		Data:              []interface{}{input.PushConfigProperty},
	}
	requestBody, err := json.Marshal(pushConfigRequest)
	if err != nil {
		return false, fmt.Errorf("unable to transform config pull request to JSON: %s", err.Error())
	}
	req, err := http.NewRequest(http.MethodPost, url, bytes.NewBuffer(requestBody))
	if err != nil {
		return false, err
	}
	c.populateHeaders(req.Header, input.RepoInfo.ClientToken)

	log.Printf("Calling %s\n", req.URL.String())

	resp, respError := c.doHttpRequestWithRetry(req, requestBody, "property push request")

	if respError != nil {
		return false, respError
	}

	if resp.StatusCode != 200 {
		return false, fmt.Errorf("property push request returned HTTP status code %d: %s", resp.StatusCode, resp.Header.Get("Etag"))
	}

	return true, nil
}

type DeletePropertyRequest struct {
	Data []interface{} `json:"data"`
}

type DeletePropertyIdentifier struct {
	Key    string                          `json:"key"`
	Vdt    string                          `json:"vdt"`
	Values []DeletePropertyIdentifierValue `json:"values"`
}

type DeletePropertyIdentifierValue struct {
	Context   string `json:"context"`
	Operation string `json:"opp"`
}

func (c *Client) doDeleteProperty(deletePropertyIdentifier DeletePropertyIdentifier, repoInfo RepoInfo) (sucess bool, err error) {
	url := c.constructFullUrl("/rest/push", repoInfo)
	deletePropertyRequest := DeletePropertyRequest{
		Data: []interface{}{deletePropertyIdentifier},
	}
	requestBody, err := json.Marshal(deletePropertyRequest)
	log.Printf("Request Body %s", string(requestBody))
	if err != nil {
		return false, fmt.Errorf("unable to transform property delete request to JSON: %s", err.Error())
	}

	var resp *http.Response

	for retry := 0; retry < 3 && (resp == nil || resp.StatusCode == 304); retry++ {
		req, err := http.NewRequest(http.MethodPost, url, bytes.NewBuffer(requestBody))
		if err != nil {
			return false, err
		}
		c.populateHeaders(req.Header, repoInfo.ClientToken)
		resp, err = c.httpClient.Do(req)
		log.Printf("Calling %s\n", req.URL.String())
		if err != nil {
			return false, fmt.Errorf("unable to issue property delete request: %s", err.Error())
		}

		_, err = ioutil.ReadAll(resp.Body)
		if err != nil {
			return false, fmt.Errorf("cannot parse response from property delete request: %s", err.Error())
		}
		defer resp.Body.Close()
		time.Sleep(time.Duration(math.Pow(2, float64(retry))) * time.Second)
		if resp.StatusCode == 304 && resp.Header.Get("Etag") == "A relationship to another item exists, preventing this transaction." {
			return c.doDeletePropertyForAllContext(deletePropertyIdentifier.Key, repoInfo)
		}
	}

	if resp.StatusCode != 200 {
		return false, fmt.Errorf("property delete request returned HTTP status code %d: %s", resp.StatusCode, resp.Header.Get("Etag"))
	}

	return true, nil
}

type DeletePropertyForAllContextIdentifier struct {
	Key       string `json:"key"`
	Operation string `json:"opp"`
}

func (c *Client) doDeletePropertyForAllContext(key string, repoInfo RepoInfo) (sucess bool, err error) {
	url := c.constructFullUrl("/rest/push", repoInfo)
	deletePropertyForAllContextIdentifier := DeletePropertyForAllContextIdentifier{
		Key: key,
	}
	deletePropertyRequest := DeletePropertyRequest{
		Data: []interface{}{deletePropertyForAllContextIdentifier},
	}
	requestBody, err := json.Marshal(deletePropertyRequest)
	log.Printf("Request Body %s", string(requestBody))
	if err != nil {
		return false, fmt.Errorf("unable to transform property delete request to JSON: %s", err.Error())
	}
	req, err := http.NewRequest(http.MethodPost, url, bytes.NewBuffer(requestBody))
	if err != nil {
		return false, err
	}
	c.populateHeaders(req.Header, repoInfo.ClientToken)

	log.Printf("Calling %s\n", req.URL.String())

	resp, respError := c.doHttpRequestWithRetry(req, requestBody, "property delete request for all context")

	if respError != nil {
		return false, respError
	}

	if resp.StatusCode != 200 {
		return false, fmt.Errorf("property delete request returned HTTP status code %d: %s", resp.StatusCode, resp.Header.Get("Etag"))
	}

	return true, nil
}

type PushConfigFile struct {
	File    string `json:"file"`
	Context string `json:"context"`
	Content string `json:"content"`
}

// HTTP POST - /rest/push
func (c *Client) doPushConfigFile(pushConfigFile PushConfigFile, repoInfo RepoInfo) (sucess bool, err error) {
	url := c.constructFullUrl("/rest/push", repoInfo)
	pushConfigRequest := PushConfigRequest{
		ChangeComment:     "Managed by Terraform",
		EnableKeyCreation: true,
		Data:              []interface{}{pushConfigFile},
	}
	requestBody, err := json.Marshal(pushConfigRequest)
	log.Printf("[INFO] Request Body %s", string(requestBody))
	if err != nil {
		return false, fmt.Errorf("unable to transform config pull request to JSON: %s", err.Error())
	}
	req, err := http.NewRequest(http.MethodPost, url, bytes.NewBuffer(requestBody))
	if err != nil {
		return false, err
	}
	c.populateHeaders(req.Header, repoInfo.ClientToken)

	log.Printf("Calling %s\n", req.URL.String())

	resp, respError := c.doHttpRequestWithRetry(req, requestBody, "file push request")

	if respError != nil {
		return false, respError
	}

	if resp.StatusCode != 200 {
		return false, fmt.Errorf("file push request returned HTTP status code %d: %s", resp.StatusCode, resp.Header.Get("Etag"))
	}

	return true, nil
}

type DeleteFileIdentifier struct {
	File      string `json:"file"`
	Context   string `json:"context"`
	Operation string `json:"opp"`
}

func (c *Client) doDeleteFile(deletePropertyIdentifier DeleteFileIdentifier, repoInfo RepoInfo) (sucess bool, err error) {
	url := c.constructFullUrl("/rest/push", repoInfo)
	deletePropertyRequest := DeletePropertyRequest{
		Data: []interface{}{deletePropertyIdentifier},
	}
	requestBody, err := json.Marshal(deletePropertyRequest)
	log.Printf("Request Body %s", string(requestBody))
	if err != nil {
		return false, fmt.Errorf("unable to transform config pull request to JSON: %s", err.Error())
	}
	req, err := http.NewRequest(http.MethodPost, url, bytes.NewBuffer(requestBody))
	if err != nil {
		return false, err
	}
	c.populateHeaders(req.Header, repoInfo.ClientToken)

	log.Printf("Calling %s\n", req.URL.String())

	resp, respError := c.doHttpRequestWithRetry(req, requestBody, "file delete request")

	if respError != nil {
		return false, respError
	}

	if resp.StatusCode != 200 {
		return false, fmt.Errorf("file delete request returned HTTP status code %d: %s", resp.StatusCode, resp.Header.Get("Etag"))
	}

	return true, nil
}
