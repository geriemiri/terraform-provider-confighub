terraform {
  required_providers {
    confighub = {
      version = "2.0.0"
      source  = "confighub.com/terraform/confighub"
    }
  }
}

provider "confighub" {
  hostname             = "localhost"
  scheme               = "http"
  port                 = 8080
  default_client_token = "eyJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJDb25maWdIdWIiLCJyaWQiOjYsInRzIjotNTQ0OTk5NDA3fQ.CkTMvi3bBYs69cJlbBG--coBybW9sbl6O4_das8cfL0"
}


data "confighub_properties" "dev_demo_app_properties" {
  depends_on = [
    confighub_property.dev_demo_app_text_property,
    confighub_property.dev_demo_app_list_property
  ]
  context = "dev;demo-app"
}

resource "confighub_property" "dev_demo_app_text_property" {
  key     = "text_value_test"
  context = "dev;demo-app"
  value   = "This is a simple string"
}

resource "confighub_property" "dev_demo_app_list_property" {
  key     = "list_value_test"
  context = "dev;demo-app"
  vdt     = "List"
  value = jsonencode([
    "Value 1",
    "Value 2"
  ])
}

resource "confighub_property" "dev_demo_app_map_property" {
  key     = "map_value_test"
  context = "dev;demo-app"
  vdt     = "Map"
  value = jsonencode({
    key_1 = "Key 1 Value",
    key_2 = "Key 2 Value"
  })
}

resource "confighub_file" "dev_demo_app_test_file" {
  path    = "test_file"
  context = "dev;demo-app"
  content = "The content of the file"
}

data "confighub_file" "dev_demo_app_test_file" {
  depends_on = [confighub_file.dev_demo_app_test_file]
  path       = "test_file"
  context    = "dev;demo-app"
}

output "dev_demo_app_properties" {
  value = data.confighub_properties.dev_demo_app_properties
}

output "dev_demo_app_list_property_first_value" {
  value = jsondecode(data.confighub_properties.dev_demo_app_properties.properties["list_value_test"])[0]
}

output "dev_demo_app_map_property_key_1_value" {
  value = jsondecode(data.confighub_properties.dev_demo_app_properties.properties["map_value_test"])["key_1"]
}

output "dev_demo_app_test_file" {
  value = data.confighub_file.dev_demo_app_test_file
}