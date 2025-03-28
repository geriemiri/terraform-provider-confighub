---
page_title: "confighub Provider"
subcategory: "ConfigHub"
description: |-
  Provider for reading and writting configuration properties and files in ConfigHub.
---

# ConfigHub Provider

Provider for reading and writting configuration properties and files in ConfigHub.

> **ATTENTION**:  This TF provider only works with the legacy open-source ConfigHub platform: https://github.com/ConfigHubPub/ConfigHubPlatform
> The provider does not work with the new ConfigHub SaaS solution

## Example Usage

```hcl
provider "confighub" {
  hostname             = "localhost"
  scheme               = "http"
  port                 = 8080
  default_client_token = "eyJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJDb25maWdIdWIiLCJyaWQiOjYsInRzIjotNTQ0OTk5NDA3fQ.CkTMvi3bBYs69cJlbBG--coBybW9sbl6O4_das8cfL0"
}
```

## Argument Reference

The list of the arguments that the providers accepts:

- `hostname` - (Required) Hostname of the ConfigHub server.
- `default_account` - (Optional) The default account through which the data is being accessed. It can be overriden at the resource or data source level. Is a required property, if `default_repository` is also defined.
- `default_client_token` - (Optional) Specifies the default Client Token forThis token uniquely identifies and authenticated a request to a specific ConfigHub repository.
- `port` - (Optional) The port used to send the requests.
- `default_repository` - (Optional) The default repository to fetch the properties and files from. It has be specified if `default_account` is specified.
- `scheme` - (Optional) Possible values are either **http** or **https**. Specifies if the requests will be made using HTTP or HTTPS respectively. Defaults to HTTPS.
