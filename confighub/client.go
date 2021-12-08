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
	"strings"
	"time"
)

var UrlBase *string
var HttpClient *http.Client

type Client struct {
	ProviderData *ProviderData
	BaseUrl      *url.URL
	httpClient   *http.Client
	headers      http.Header
}

// NewClient initializes a new Client instance to communicate with the CMDB api
func NewClient(providerData *ProviderData, h http.Header) *Client {
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

	if h != nil {
		client.headers = h
	}

	return client
}

func (c *Client) constructFullUrl(path string) string {
	url := ""
	if c.ProviderData.Account != "" && c.ProviderData.Repository != "" {
		url = fmt.Sprintf("%s%s/%s/%s", c.BaseUrl, path, c.ProviderData.Account, c.ProviderData.Repository)
	} else {
		url = fmt.Sprintf("%s%s", c.BaseUrl, path)
	}
	return url
}

// HTTP GET - /rest/pull
func (c *Client) doPullConfigProperties(headers http.Header) (objmap map[string]interface{}, err error) {
	url := c.constructFullUrl("/rest/pull")
	req, err := http.NewRequest(http.MethodGet, url, nil)
	if err != nil {
		return nil, err
	}
	for name, value := range headers {
		req.Header.Add(name, strings.Join(value, ""))
	}
	req.Header.Add("No-Files", "true")

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

func (c *Client) doPullConfigFile(headers http.Header) (fileContent string, err error) {
	url := c.constructFullUrl("/rest/rawFile")
	req, err := http.NewRequest(http.MethodGet, url, nil)
	if err != nil {
		return "", err
	}
	for name, value := range headers {
		req.Header.Add(name, strings.Join(value, ""))
	}

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

// HTTP POST - /rest/push
func (c *Client) doPushConfigProperty(pushConfigProperty PushConfigProperty, headers http.Header) (sucess bool, err error) {
	url := c.constructFullUrl("/rest/push")
	pushConfigRequest := PushConfigRequest{
		ChangeComment:     "Managed by Terraform",
		EnableKeyCreation: true,
		Data:              []interface{}{pushConfigProperty},
	}
	requestBody, err := json.Marshal(pushConfigRequest)
	if err != nil {
		return false, fmt.Errorf("unable to transform config pull request to JSON: %s", err.Error())
	}
	req, err := http.NewRequest(http.MethodPost, url, bytes.NewBuffer(requestBody))
	if err != nil {
		return false, err
	}
	for name, value := range headers {
		req.Header.Add(name, strings.Join(value, ""))
	}

	log.Printf("Calling %s\n", req.URL.String())

	var resp *http.Response
	var respError error

	for retry := 0; retry < 3 && (resp == nil || resp.StatusCode == 304); retry++ {
		resp, respError = c.httpClient.Do(req)
		if respError != nil {
			return false, fmt.Errorf("unable to issue property push request: %s", respError.Error())
		}

		_, respError = ioutil.ReadAll(resp.Body)
		if respError != nil {
			return false, fmt.Errorf("cannot parse response from property push request: %s", respError.Error())
		}
		defer resp.Body.Close()
		time.Sleep(time.Duration(math.Pow(2, float64(retry)+1)) * time.Second)
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

func (c *Client) doDeleteProperty(deletePropertyIdentifier DeletePropertyIdentifier, headers http.Header) (sucess bool, err error) {
	url := c.constructFullUrl("/rest/push")
	deletePropertyRequest := DeletePropertyRequest{
		Data: []interface{}{deletePropertyIdentifier},
	}
	requestBody, err := json.Marshal(deletePropertyRequest)
	if err != nil {
		return false, fmt.Errorf("unable to transform property delete request to JSON: %s", err.Error())
	}
	req, err := http.NewRequest(http.MethodPost, url, bytes.NewBuffer(requestBody))
	if err != nil {
		return false, err
	}
	for name, value := range headers {
		req.Header.Add(name, strings.Join(value, ""))
	}

	log.Printf("Calling %s\n", req.URL.String())

	var resp *http.Response
	var respError error

	for retry := 0; retry < 3 && (resp == nil || resp.StatusCode == 304); retry++ {
		resp, respError = c.httpClient.Do(req)
		if respError != nil {
			return false, fmt.Errorf("unable to issue property delete request: %s", respError.Error())
		}

		_, respError = ioutil.ReadAll(resp.Body)
		if err != nil {
			return false, fmt.Errorf("cannot parse response from property delete request: %s", respError.Error())
		}
		defer resp.Body.Close()
		time.Sleep(time.Duration(math.Pow(2, float64(retry))) * time.Second)
		if resp.StatusCode == 304 && resp.Header.Get("Etag") == "A relationship to another item exists, preventing this transaction." {
			return c.doDeletePropertyForAllContext(deletePropertyIdentifier.Key, headers)
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

func (c *Client) doDeletePropertyForAllContext(key string, headers http.Header) (sucess bool, err error) {
	url := c.constructFullUrl("/rest/push")
	deletePropertyForAllContextIdentifier := DeletePropertyForAllContextIdentifier{
		Key: key,
	}
	deletePropertyRequest := DeletePropertyRequest{
		Data: []interface{}{deletePropertyForAllContextIdentifier},
	}
	requestBody, err := json.Marshal(deletePropertyRequest)
	if err != nil {
		return false, fmt.Errorf("unable to transform property delete request to JSON: %s", err.Error())
	}
	req, err := http.NewRequest(http.MethodPost, url, bytes.NewBuffer(requestBody))
	if err != nil {
		return false, err
	}
	for name, value := range headers {
		req.Header.Add(name, strings.Join(value, ""))
	}

	log.Printf("Calling %s\n", req.URL.String())

	var resp *http.Response
	var respError error

	for retry := 0; retry < 3 && (resp == nil || resp.StatusCode == 304); retry++ {
		resp, respError = c.httpClient.Do(req)
		if respError != nil {
			return false, fmt.Errorf("unable to issue property delete request: %s", respError.Error())
		}

		_, respError = ioutil.ReadAll(resp.Body)
		if err != nil {
			return false, fmt.Errorf("cannot parse response from property delete request: %s", respError.Error())
		}
		defer resp.Body.Close()
		time.Sleep(time.Duration(math.Pow(2, float64(retry))) * time.Second)
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
func (c *Client) doPushConfigFile(pushConfigFile PushConfigFile, headers http.Header) (sucess bool, err error) {
	url := c.constructFullUrl("/rest/push")
	pushConfigRequest := PushConfigRequest{
		ChangeComment:     "Managed by Terraform",
		EnableKeyCreation: true,
		Data:              []interface{}{pushConfigFile},
	}
	requestBody, err := json.Marshal(pushConfigRequest)
	if err != nil {
		return false, fmt.Errorf("unable to transform config pull request to JSON: %s", err.Error())
	}
	req, err := http.NewRequest(http.MethodPost, url, bytes.NewBuffer(requestBody))
	if err != nil {
		return false, err
	}
	for name, value := range headers {
		req.Header.Add(name, strings.Join(value, ""))
	}

	log.Printf("Calling %s\n", req.URL.String())

	resp, err := c.httpClient.Do(req)
	if err != nil {
		return false, fmt.Errorf("unable to issue file push request: %s", err.Error())
	}

	_, err = ioutil.ReadAll(resp.Body)
	if err != nil {
		return false, fmt.Errorf("cannot parse response from file push request: %s", err.Error())
	}
	defer resp.Body.Close()

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

func (c *Client) doDeleteFile(deletePropertyIdentifier DeleteFileIdentifier, headers http.Header) (sucess bool, err error) {
	url := c.constructFullUrl("/rest/push")
	deletePropertyRequest := DeletePropertyRequest{
		Data: []interface{}{deletePropertyIdentifier},
	}
	requestBody, err := json.Marshal(deletePropertyRequest)
	if err != nil {
		return false, fmt.Errorf("unable to transform config pull request to JSON: %s", err.Error())
	}
	req, err := http.NewRequest(http.MethodPost, url, bytes.NewBuffer(requestBody))
	if err != nil {
		return false, err
	}
	for name, value := range headers {
		req.Header.Add(name, strings.Join(value, ""))
	}

	log.Printf("Calling %s\n", req.URL.String())

	resp, err := c.httpClient.Do(req)
	if err != nil {
		return false, fmt.Errorf("unable to issue file delete request: %s", err.Error())
	}

	_, err = ioutil.ReadAll(resp.Body)
	if err != nil {
		return false, fmt.Errorf("cannot parse response from file delete request: %s", err.Error())
	}
	defer resp.Body.Close()

	if resp.StatusCode != 200 {
		return false, fmt.Errorf("file delete request returned HTTP status code %d: %s", resp.StatusCode, resp.Header.Get("Etag"))
	}

	return true, nil
}
