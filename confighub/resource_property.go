package confighub

import (
	"context"
	"encoding/json"
	"log"
	"reflect"
	"strings"

	"github.com/hashicorp/terraform-plugin-sdk/v2/diag"
	"github.com/hashicorp/terraform-plugin-sdk/v2/helper/schema"
)

func resourceProperty() *schema.Resource {
	return &schema.Resource{
		CreateContext: resourcePropertyCreate,
		ReadContext:   resourcePropertyRead,
		UpdateContext: resourcePropertyUpdate,
		DeleteContext: resourcePropertyDelete,
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
			"key": {
				Type:     schema.TypeString,
				Required: true,
				ForceNew: true,
			},
			"deprecated": {
				Type:     schema.TypeBool,
				Optional: true,
				Default:  false,
			},
			"readme": {
				Type:     schema.TypeString,
				Optional: true,
			},
			"vdt": {
				Type:     schema.TypeString,
				Optional: true,
				Default:  "Text",
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
			"context": {
				Type:     schema.TypeString,
				Required: true,
				ForceNew: true,
			},
			"value": {
				Type:     schema.TypeString,
				Required: true,
				DiffSuppressFunc: func(k, old, new string, d *schema.ResourceData) bool {
					var o1 interface{}
					var o2 interface{}

					var err error
					err = json.Unmarshal([]byte(old), &o1)
					if err != nil {
						return false
					}
					err = json.Unmarshal([]byte(new), &o2)
					if err != nil {
						return false
					}
					return reflect.DeepEqual(o1, o2)
				},
			},
			"active": {
				Type:     schema.TypeBool,
				Optional: true,
				Default:  true,
			},
		},
	}
}

func resourcePropertyCreate(ctx context.Context, d *schema.ResourceData, meta interface{}) diag.Diagnostics {

	var diags diag.Diagnostics

	provider := meta.(ProviderClient)
	client := provider.Client

	key := d.Get("key").(string)
	context := d.Get("context").(string)
	vdt := d.Get("vdt").(string)
	id := key + "|" + context
	if !isPropertyTypeValid(d.Get("vdt").(string)) {
		return diag.Errorf("invalid vdt for property %s from context %s: %s", key, context, vdt)
	}

	pushConfigPropertyValue := PushConfigPropertyValue{
		Context: context,
		Value:   d.Get("value").(string),
		Active:  d.Get("active").(bool),
	}
	pushConfigPropertyValues := []PushConfigPropertyValue{pushConfigPropertyValue}
	pushConfigProperty := PushConfigProperty{
		Key:           key,
		Deprecated:    d.Get("deprecated").(bool),
		Readme:        d.Get("readme").(string),
		Vdt:           vdt,
		Push:          true,
		SecurityGroup: d.Get("security_group").(string),
		Password:      d.Get("password").(string),
		Values:        pushConfigPropertyValues,
	}
	input := PushConfigPropertyInput{
		PushConfigProperty: pushConfigProperty,
		RepoInfo:           client.getRepoInfo(d),
	}
	_, err := client.doPushConfigProperty(input)
	if err != nil {
		return diag.Errorf("Error pushing configs: %s", err)
	}
	d.SetId(id)
	return diags
}

func resourcePropertyRead(ctx context.Context, d *schema.ResourceData, meta interface{}) diag.Diagnostics {

	var diags diag.Diagnostics

	provider := meta.(ProviderClient)
	client := provider.Client

	propertyId := d.Id()

	propertyIdParts := strings.Split(propertyId, "|")
	propertyKey := propertyIdParts[0]
	log.Printf("[DEBUG] propertyKey %s\n", propertyKey)
	propertyContext := propertyIdParts[1]
	log.Printf("[DEBUG] propertyContext %s\n", propertyContext)

	d.Set("key", propertyKey)
	d.Set("context", propertyContext)

	input := PullConfigPropertiesInput{
		Context:  propertyContext,
		RepoInfo: client.getRepoInfo(d),
	}

	objmap, err := client.doPullConfigProperties(input)
	log.Printf("[DEBUG] Key %s\n", objmap)

	if err != nil {
		return diag.Errorf("Error pulling configs: %s", err)
	}

	propertiesReflexiveMap := reflect.ValueOf(objmap["properties"])

	isValuePresent := false
	for _, key := range propertiesReflexiveMap.MapKeys() {
		value := propertiesReflexiveMap.MapIndex(key)
		propertyValue := value.Interface().(map[string]interface{})
		log.Printf("[DEBUG] Key %s\n", key)
		if key.String() == propertyKey {
			propertyType, typePresent := propertyValue["type"]
			isValuePresent = true
			if typePresent {
				d.Set("vdt", propertyType)
			} else {
				d.Set("vdt", "Text")
			}
			if propertyType == "List" || propertyType == "Map" {
				propertyJson, err := json.MarshalIndent(propertyValue["val"], "", "\t")
				if err != nil {
					return diag.Errorf("error for property %s context %s as List or Map: %s", propertyKey, propertyContext, err)
				}
				d.Set("value", string(propertyJson))
			} else {
				d.Set("value", propertyValue["val"].(string))
			}
		}
	}

	if !isValuePresent {
		log.Printf("Property %s for context %s was not found", propertyKey, propertyContext)
		return resourcePropertyCreate(ctx, d, meta)
	}

	return diags
}

func resourcePropertyUpdate(ctx context.Context, d *schema.ResourceData, meta interface{}) diag.Diagnostics {
	return resourcePropertyCreate(ctx, d, meta)
}

func resourcePropertyDelete(ctx context.Context, d *schema.ResourceData, meta interface{}) diag.Diagnostics {

	var diags diag.Diagnostics

	provider := meta.(ProviderClient)
	client := provider.Client

	propertyId := d.Id()

	propertyIdParts := strings.Split(propertyId, "|")
	propertyKey := propertyIdParts[0]
	propertyContext := propertyIdParts[1]
	vdt := d.Get("vdt").(string)

	deletePropertyIdentifierValue := DeletePropertyIdentifierValue{
		Context:   propertyContext,
		Operation: "delete",
	}
	deletePropertyIdentifier := DeletePropertyIdentifier{
		Key:    propertyKey,
		Vdt:    vdt,
		Values: []DeletePropertyIdentifierValue{deletePropertyIdentifierValue},
	}
	_, err := client.doDeleteProperty(deletePropertyIdentifier, client.getRepoInfo(d))
	if err != nil {
		return diag.Errorf("Error deleting property %s from context %s: %s", propertyKey, propertyContext, err)
	}
	return diags
}

func isPropertyTypeValid(propertyType string) bool {
	switch propertyType {
	case "Text", "Boolean", "Integer", "Long", "Float", "Double", "FileRef", "FileEmbed", "JSON", "Code", "List", "Map":
		return true
	}
	return false
}
