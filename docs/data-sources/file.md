---
page_title: "confighub_file Data Source - terraform-provider-confighub"
subcategory: "File"
description: |-
  Gets configuration file content
---

# confighub_file (Data Source)

Gets a configuration file from ConfigHub using the path and context.

## Example Usage

```terraform
data "confighub_file" "dev_demo_app_test_file" {
  path       = "test_file"
  context    = "dev;demo-app"
}
```

## Argument Reference

* `context` - (Required) The domain of the certificate to look up. If no certificate is found with this name, an error will be returned.
* `path` - (Required) The file path.
* `client_token` - (Optional) Client Token to authenticate the requests.
* `account` - (Optional) Account name.
* `repository` - (Optional) Repository name.
* `application_name` - (Optional) This field helps you identify application or a client pulling configuration. Visible in Pull Request tab.
* `repository_date` - (Optional) ISO 8601 date format (UTC) YYYY-MM-DDTHH:MM:SSZ lets you specify a point in time for which to pull configuration. If not specified, latest configuration is returned.
* `tag` - (Optional) Name of the defined tag. Returned configuration is for a point in time as specified by the tag. If both Tag and Repository-Date headers are specified, Repository-Date is only used if the tag is no longer available.

## Attributes Reference

* `content` -  The content of the file.