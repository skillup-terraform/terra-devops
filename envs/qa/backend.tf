terraform {
    backend "azurerm" {
    resource_group_name = "terraform-rg"
    subscription_id = "625212d8-b50c-4d34-91c2-acce39814b8b"
    storage_account_name = "terraformstatexxxx"
    container_name = "state"
    key = "qa.tfstate"
  }
}