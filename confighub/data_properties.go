package confighub

import (
	"context"
	"encoding/json"
	"reflect"

	"github.com/hashicorp/terraform-plugin-sdk/v2/diag"
	"github.com/hashicorp/terraform-plugin-sdk/v2/helper/schema"
)

func dataPropertiesSchema() *schema.Resource {
	return &schema.Resource{
		ReadContext: dataPropertiesRead,
		Schema: map[string]*schema.Schema{
			"context": {
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
			"account": {
				Type:     schema.TypeString,
				Computed: true,
			},
			"repo": {
				Type:     schema.TypeString,
				Computed: true,
			},
			"properties": {
				Type:     schema.TypeMap,
				Computed: true,
			},
		},
	}
}

func dataPropertiesRead(ctx context.Context, d *schema.ResourceData, meta interface{}) diag.Diagnostics {
	var diags diag.Diagnostics

	provider := meta.(ProviderClient)
	client := provider.Client

	context := d.Get("context").(string)
	applicationName := d.Get("application_name").(string)
	tag := d.Get("tag").(string)
	repositoryDate := d.Get("repository_date").(string)

	headers := client.headers.Clone()
	headers.Add("Context", context)
	if applicationName != "" {
		headers.Add("Application-Name", applicationName)
	}
	if tag != "" {
		headers.Add("Tag", tag)
	}
	if repositoryDate != "" {
		headers.Add("Repository-Date", repositoryDate)
	}

	objmap, err := client.doPullConfigProperties(headers)

	if err != nil {
		return diag.Errorf("Error pulling configs: %s", err)
	}

	account := objmap["account"].(string)
	repo := objmap["repo"].(string)
	d.SetId(account + "|" + repo + "|" + context)
	d.Set("account", account)
	d.Set("repo", repo)

	properties := make(map[string]string)

	propertiesReflexiveMap := reflect.ValueOf(objmap["properties"])

	for _, key := range propertiesReflexiveMap.MapKeys() {
		value := propertiesReflexiveMap.MapIndex(key)
		propertyValue := value.Interface().(map[string]interface{})
		switch propertyValue["type"] {
		case nil, "Boolean", "Integer", "Long", "Float", "Double", "FileRef", "FileEmbed", "JSON", "Code":
			properties[key.String()] = propertyValue["val"].(string)
		case "List", "Map":
			propertyJson, err := json.MarshalIndent(propertyValue["val"], "", "\t")
			if err != nil {
				return diag.Errorf("error for property %s context %s as List or Map: %s", key, context, err)
			}
			properties[key.String()] = string(propertyJson)
		}
	}
	d.Set("properties", properties)
	return diags
}
