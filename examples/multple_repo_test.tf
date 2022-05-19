locals {
  demo_2_client_token = "eyJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJDb25maWdIdWIiLCJyaWQiOjk1LCJ0cyI6LTYxMDk0MjA3Nn0.OojriS9t32nYeoXnvpsH7LkbCoueeRzTBk_EDfBbbf8"
}

data "confighub_properties" "second_dev_demo_app_properties" {
  depends_on = [
    confighub_property.dev_demo_app_text_property,
    confighub_property.dev_demo_app_list_property
  ]
  client_token = local.demo_2_client_token
  context      = "dev;demo-app"
}

resource "confighub_property" "second_dev_demo_app_text_property" {
  client_token = local.demo_2_client_token
  key          = "text_value_test"
  context      = "dev;demo-app"
  value        = "This is a simple string"
}

resource "confighub_property" "second_dev_demo_app_list_property" {
  client_token = local.demo_2_client_token
  key          = "list_value_test"
  context      = "dev;demo-app"
  vdt          = "List"
  value = jsonencode([
    "Value 1",
    "Value 2"
  ])
}

resource "confighub_property" "second_dev_demo_app_map_property" {
  client_token = local.demo_2_client_token
  key          = "map_value_test"
  context      = "dev;demo-app"
  vdt          = "Map"
  value = jsonencode({
    key_1 = "Key 1 Value",
    key_2 = "Key 2 Value"
  })
}

resource "confighub_file" "second_dev_demo_app_test_file" {
  client_token = local.demo_2_client_token
  path         = "test_file"
  context      = "dev;demo-app"
  content      = "The content of the file"
}

data "confighub_file" "second_dev_demo_app_test_file" {
  depends_on   = [confighub_file.second_dev_demo_app_test_file]
  client_token = local.demo_2_client_token
  path         = "test_file"
  context      = "dev;demo-app"
}

output "second_dev_demo_app_properties" {
  value = data.confighub_properties.second_dev_demo_app_properties
}

output "second_dev_demo_app_list_property_first_value" {
  value = jsondecode(data.confighub_properties.second_dev_demo_app_properties.properties["list_value_test"])[0]
}

output "second_dev_demo_app_map_property_key_1_value" {
  value = jsondecode(data.confighub_properties.second_dev_demo_app_properties.properties["map_value_test"])["key_1"]
}

output "second_dev_demo_app_test_file" {
  value = data.confighub_file.second_dev_demo_app_test_file
}