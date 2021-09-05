---
page_title: "confighub_properties Data Source - terraform-provider-confighub"
subcategory: "Property"
description: |-
  Gets all the configuration properties of a context as a key-value map.
---

# confighub_properties (Data Source)

Gets the all the configuration properties of ConfigHub part of a context.

## Example Usage

```terraform
data "confighub_properties" "dev_demo_app_properties" {
  context    = "dev;demo-app"
}
```

## Argument Reference

* `context` - (Required) The domain of the certificate to look up. If no certificate is found with this name, an error will be returned.
* `application_name` - (Optional) This field helps you identify application or a client pulling configuration. Visible in Pull Request tab.
* `repository_date` - (Optional) ISO 8601 date format (UTC) YYYY-MM-DDTHH:MM:SSZ lets you specify a point in time for which to pull configuration. If not specified, latest configuration is returned.
* `tag` - (Optional) Name of the defined tag. Returned configuration is for a point in time as specified by the tag. If both Tag and Repository-Date headers are specified, Repository-Date is only used if the tag is no longer available.

## Attributes Reference

* `properties` -  A mapping of all properties for specified context.
* `account` - Account used to access ConfigHub properties.
* `repo` - The name of the repository.