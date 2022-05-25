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

	input := PullConfigPropertiesInput{
		Context:         context,
		ApplicationName: d.Get("application_name").(string),
		Tag:             d.Get("tag").(string),
		RepositoryDate:  d.Get("repository_date").(string),
		RepoInfo:        client.getRepoInfo(d),
	}

	objmap, err := client.doPullConfigProperties(input)

	if err != nil {
		return diag.Errorf("Error pulling configs: %s", err)
	}

	account := objmap["account"].(string)
	repo := objmap["repo"].(string)
	d.SetId(account + "|" + repo + "|" + context)
	d.Set("account", account)
	d.Set("repository", repo)

	properties := make(map[string]string)

	propertiesReflexiveMap := reflect.ValueOf(objmap["properties"])

	for _, key := range propertiesReflexiveMap.MapKeys() {
		value := propertiesReflexiveMap.MapIndex(key)
		propertyValue := value.Interface().(map[string]interface{})
		switch propertyValue["type"] {
		case nil, "Boolean", "Integer", "Long", "Float", "Double", "FileRef", "FileEmbed", "JSON", "Code":
			properties[key.String()] = propertyValue["val"].(string)
		case "List", "Map":
			propertyJson, err := json.Marshal(propertyValue["val"])
			if err != nil {
				return diag.Errorf("error for property %s context %s as List or Map: %s", key, context, err)
			}
			properties[key.String()] = string(propertyJson)
		}
	}
	d.Set("properties", properties)
	return diags
}
