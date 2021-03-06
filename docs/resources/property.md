---
# generated by https://github.com/hashicorp/terraform-plugin-docs
page_title: "confighub_property Resource - terraform-provider-confighub"
subcategory: "Property"
description: |-
  Manages a configuration property in ConfigHub.
---

# confighub_property (Resource)

Manages a configuration property in ConfigHub.

## Example Usage

### Property with Text type

```terraform
resource "confighub_property" "dev_demo_app_text_property" {
  key      = "text_value_test"
  context  = "dev;demo-app"
  value    = "This is a simple string"
}
```

### Property with List type

```terraform
resource "confighub_property" "dev_demo_app_list_property" {
  key      = "list_value_test"
  context  = "dev;demo-app"
  vdt = "List"
  value    = jsonencode([
    "Value 1",
    "Value 2"
  ])
}
```

### Property with Map type

```terraform
resource "confighub_property" "dev_demo_app_map_property" {
  key      = "map_value_test"
  context  = "dev;demo-app"
  vdt      = "Map"
  value    = jsonencode({
    key_1 = "Key 1 Value",
    key_2 = "Key 2 Value"
  })
}
```

## Property with its own client_token

```terraform
resource "confighub_property" "dev_demo_app_text_property" {
  key          = "text_value_test"
  context      = "dev;demo-app"
  value        = "This is a simple string"
  client_token = "kaPQWMOKAOCMGGPIFMasodiwm..."
}
```

## Argument Reference

The following arguments are required:

* `context` - (Required) A string denoting the context, where all the context parts are concatenated with semicolumn `;`.
* `key` - (Required) The key of the property.
* `value` - (Required) The value of the property.

The following arguments are optional:

* `client_token` - (Optional) Client Token to authenticate the requests.
* `account` - (Optional) Account name.
* `repository` - (Optional) Repository name.
* `vdt` - (Optional) The type of the property. Defaults to Text.
* `readme` - (Optional) Description of the property.
* `active` - (Optional) Boolean value, either `true` or `false` that denotes if the property is active or not. Defaults to `true`.
* `deprecated` - (Optional) Boolean value, either `true` or `false` that denotes if the property is deprecated or not
* `security_group` - (Optional) Security group name that is used to encrypt the property.
* `password` - (Optional) Password for the security group.

## Import

Configuration file resource can be imported using a concatenation of `key` with `context` with `|` as a delimiter, e.g.

```
$ terraform import confighub_property.dev_demo_app_text_property text_value_test|dev;demo-app
```