package confighub

import (
	"context"
	"log"
	"strings"

	"github.com/hashicorp/terraform-plugin-sdk/v2/diag"
	"github.com/hashicorp/terraform-plugin-sdk/v2/helper/schema"
)

func resourceFile() *schema.Resource {
	return &schema.Resource{
		CreateContext: resourceFileCreate,
		ReadContext:   resourceFileRead,
		UpdateContext: resourceFileUpdate,
		DeleteContext: resourceFileDelete,
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
			"path": {
				Type:     schema.TypeString,
				Required: true,
				ForceNew: true,
			},
			"context": {
				Type:     schema.TypeString,
				Required: true,
				ForceNew: true,
			},
			"content": {
				Type:     schema.TypeString,
				Required: true,
			},
			"application_name": {
				Type:     schema.TypeString,
				Optional: true,
			},
			"security_group": {
				Type:     schema.TypeString,
				Optional: true,
				ForceNew: true,
			},
			"password": {
				Type:     schema.TypeString,
				Optional: true,
				ForceNew: true,
			},
		},
	}
}

func resourceFileCreate(ctx context.Context, d *schema.ResourceData, meta interface{}) diag.Diagnostics {

	var diags diag.Diagnostics

	provider := meta.(ProviderClient)
	client := provider.Client

	pushConfigFile := PushConfigFile{
		File:    d.Get("path").(string),
		Context: d.Get("context").(string),
		Content: d.Get("content").(string),
	}
	_, err := client.doPushConfigFile(pushConfigFile, client.getRepoInfo(d))
	if err != nil {
		return diag.Errorf("Error pushing config file %s for context %s: %s", pushConfigFile.File, pushConfigFile.Context, err)
	}
	d.SetId(pushConfigFile.File + "|" + pushConfigFile.Context)
	return diags
}

func resourceFileRead(ctx context.Context, d *schema.ResourceData, meta interface{}) diag.Diagnostics {

	var diags diag.Diagnostics

	provider := meta.(ProviderClient)
	client := provider.Client

	propertyId := d.Id()

	propertyIdParts := strings.Split(propertyId, "|")
	filePath := propertyIdParts[0]
	log.Printf("[DEBUG] filePath %s\n", filePath)
	context := propertyIdParts[1]
	log.Printf("[DEBUG] context %s\n", context)

	d.Set("path", filePath)
	d.Set("context", context)

	input := PullConfigFileInput{
		Context:  context,
		FilePath: filePath,
		RepoInfo: client.getRepoInfo(d),
	}

	content, err := client.doPullConfigFile(input)

	if err != nil {
		return diag.Errorf("Error pulling config file %s for context %s: %s", filePath, context, err)
	}
	d.Set("content", content)

	return diags
}

func resourceFileUpdate(ctx context.Context, d *schema.ResourceData, meta interface{}) diag.Diagnostics {
	return resourceFileCreate(ctx, d, meta)
}

func resourceFileDelete(ctx context.Context, d *schema.ResourceData, meta interface{}) diag.Diagnostics {

	var diags diag.Diagnostics

	provider := meta.(ProviderClient)
	client := provider.Client

	propertyId := d.Id()

	propertyIdParts := strings.Split(propertyId, "|")
	filePath := propertyIdParts[0]
	context := propertyIdParts[1]

	deleteFileIdentifier := DeleteFileIdentifier{
		File:      filePath,
		Context:   context,
		Operation: "delete",
	}
	_, err := client.doDeleteFile(deleteFileIdentifier, client.getRepoInfo(d))
	if err != nil {
		return diag.Errorf("Error deleting config file %s for context %s: %s", filePath, context, err)
	}
	return diags
}
