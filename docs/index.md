---
page_title: "confighub Provider"
subcategory: "ConfigHub"
description: |-
  Provider for reading and writting configuration properties and files in ConfigHub.
---

# ConfigHub Provider

Provider for reading and writting configuration properties and files in ConfigHub.

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
- `default_account` - (Optional) The account through which the data is being accessed. This is not required if a `default_client_token` is specified. If `default_client_token` is missing, then both `default_account` and `default_repository` must be specified.
- `default_client_token` - (Optional) The `default_client_token` is required if no `account` and `repository` is specified. This token uniquely identifies and authenticated a request to a specific ConfigHub repository.
- `port` - (Optional) The port used to send the requests.
- `default_repository` - (Optional) The default repository to fetch the properties and files from. It has be specified if `default_account` is specified.
- `scheme` - (Optional) Possible values are either **http** or **https**. Specifies if the requests will be made using HTTP or HTTPS respectively. Defaults to HTTPS.
