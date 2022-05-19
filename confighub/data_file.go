package confighub

import (
	"context"

	"github.com/hashicorp/terraform-plugin-sdk/v2/diag"
	"github.com/hashicorp/terraform-plugin-sdk/v2/helper/schema"
)

func dataFileSchema() *schema.Resource {
	return &schema.Resource{
		ReadContext: dataFileRead,
		Schema: map[string]*schema.Schema{
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
			"context": {
				Type:     schema.TypeString,
				Required: true,
			},
			"path": {
				Type:     schema.TypeString,
				Required: true,
			},
			"application_name": {
				Type:     schema.TypeString,
				Optional: true,
			},
			"repository_date": {
				Type:     schema.TypeString,
				Optional: true,
			},
			"tag": {
				Type:     schema.TypeString,
				Optional: true,
			},
			"content": {
				Type:     schema.TypeString,
				Computed: true,
			},
		},
	}
}

func dataFileRead(ctx context.Context, d *schema.ResourceData, meta interface{}) diag.Diagnostics {
	var diags diag.Diagnostics

	provider := meta.(ProviderClient)
	client := provider.Client

	context := d.Get("context").(string)
	filePath := d.Get("path").(string)

	input := PullConfigFileInput{
		Context:         context,
		FilePath:        filePath,
		ApplicationName: d.Get("application_name").(string),
		Tag:             d.Get("tag").(string),
		RepositoryDate:  d.Get("repository_date").(string),
	}

	fileContent, err := client.doPullConfigFile(input)

	if err != nil {
		return diag.Errorf("Error pulling file config %s for context %s: %s", filePath, context, err)
	}

	d.SetId(filePath + "|" + context)
	d.Set("content", fileContent)

	return diags
}
