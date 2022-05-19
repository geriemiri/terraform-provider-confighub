package confighub

import (
	"context"

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
			"default_account": {
				Type:     schema.TypeString,
				Optional: true,
			},
			"default_repository": {
				Type:     schema.TypeString,
				Optional: true,
			},
			"default_client_token": {
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
	Hostname           string
	Scheme             string
	Port               int
	DefaultAccount     string
	DefaultRepository  string
	DefaultClientToken string
	ClientVersion      string
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
	defaultAccount := d.Get("default_account").(string)
	defaultRepository := d.Get("default_repository").(string)
	defaultClientToken := d.Get("default_client_token").(string)

	var diags diag.Diagnostics

	if scheme != "http" && scheme != "https" {
		return nil, diag.Errorf("scheme must be either http or https")
	}

	if (defaultAccount == "" && defaultRepository != "") || (defaultAccount != "" && defaultRepository == "") {
		return nil, diag.Errorf("Both default_account and default_repository properties have to specified")
	}

	clientVersion := d.Get("client_version").(string)

	providerData := ProviderData{
		Hostname:           hostname,
		Scheme:             scheme,
		Port:               port,
		DefaultAccount:     defaultAccount,
		DefaultRepository:  defaultRepository,
		DefaultClientToken: defaultClientToken,
		ClientVersion:      clientVersion,
	}
	providerClient := ProviderClient{
		ProviderData: &providerData,
	}
	providerClient.Client = NewClient(&providerData)

	return providerClient, diags
}
