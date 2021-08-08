package confighub

import (
	"context"
	"log"
	"net/http"

	"github.com/hashicorp/terraform-plugin-sdk/v2/diag"
	"github.com/hashicorp/terraform-plugin-sdk/v2/helper/schema"
)

// Provider -
func Provider() *schema.Provider {
	return &schema.Provider{
		Schema: map[string]*schema.Schema{
			"hostname": {
				Type:     schema.TypeString,
				Required: true,
			},
			"port": {
				Type:     schema.TypeInt,
				Optional: true,
			},
			"scheme": {
				Type:     schema.TypeString,
				Optional: true,
				Default:  "https",
			},
			"account": {
				Type:     schema.TypeString,
				Optional: true,
			},
			"repository": {
				Type:     schema.TypeString,
				Optional: true,
			},
			"client_token": {
				Type:     schema.TypeString,
				Optional: true,
			},
			"client_version": {
				Type:     schema.TypeString,
				Optional: true,
			},
		},
		DataSourcesMap: map[string]*schema.Resource{
			"confighub_properties": dataPropertiesSchema(),
			"confighub_file":       dataFileSchema(),
		},
		ResourcesMap: map[string]*schema.Resource{
			"confighub_property": resourceProperty(),
			"confighub_file":     resourceFile(),
		},
		ConfigureContextFunc: providerConfigure,
	}
}

// ProviderClient holds metadata / config for use by Terraform resources
type ProviderData struct {
	Hostname      string
	Scheme        string
	Port          int
	Account       string
	Repository    string
	ClientToken   string
	ClientVersion string
}

type ProviderClient struct {
	ProviderData *ProviderData
	Client       *Client
}

// providerConfigure parses the config into the Terraform provider meta object
func providerConfigure(ctx context.Context, d *schema.ResourceData) (interface{}, diag.Diagnostics) {
	hostname := d.Get("hostname").(string)
	scheme := d.Get("scheme").(string)
	port := d.Get("port").(int)
	account := d.Get("account").(string)
	repository := d.Get("repository").(string)
	clientToken := d.Get("client_token").(string)

	var diags diag.Diagnostics

	if scheme != "http" && scheme != "https" {
		return nil, diag.Errorf("scheme must be either http or https")
	}

	if (account == "" || repository == "") && clientToken == "" {
		return nil, diag.Errorf("Either account and repository properties have to specified or client_token property has to be specified")
	}

	headers := make(http.Header)
	headers.Set("Content-Type", "application/json")
	headers.Set("Accept", "application/json")

	if clientToken != "" {
		headers.Set("Client-Token", clientToken)
	}

	clientVersion := d.Get("client_version").(string)
	if clientVersion == "" {
		log.Println("Using the latest client_version")
	} else {
		headers.Set("Client-Version", clientVersion)
	}

	providerData := ProviderData{
		Hostname:      hostname,
		Scheme:        scheme,
		Port:          port,
		Account:       account,
		Repository:    repository,
		ClientToken:   clientToken,
		ClientVersion: clientVersion,
	}
	providerClient := ProviderClient{
		ProviderData: &providerData,
	}
	providerClient.Client = NewClient(&providerData, headers)

	return providerClient, diags
}
