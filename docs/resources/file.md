---
page_title: "confighub_file Resource - terraform-provider-confighub"
subcategory: "File"
description: |-
  Manages a configuration file in ConfigHub.
---

# confighub_file (Resource)

Manages a configuration file in ConfigHub.

## Example Usage

```terraform
resource "confighub_file" "dev_demo_app_test_file" {
  path     = "test_file"
  context  = "dev;demo-app"
  content  = "The content of the file"
}
```

## Argument Reference

The following arguments are required:

* `context` - (Required) A string denoting the context, where all the context parts are concatenated with semicolumn `;`.
* `path` - (Required) The path of the configuration file.
* `content` - (Required) The content of the configuration file.

The following arguments are optional:

* `application_name` - (Optional) Application name.
* `security_group` - (Optional) Security group name that is used to encrypt the file.
* `password` - (Optional) Password for the security group.

## Import

Configuration file resource can be imported using a concatenation of `path` with `context` with `|` as a delimiter, e.g.

```
$ terraform import confighub_file.dev_demo_app_test_file test_file|dev;demo-app
```