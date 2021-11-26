provider azurerm {
  version = "~>2.0"
  features {}
}
terraform {
  backend "azurerm" {
    resource_group_name = "rg-cloudquickpos"
    storage_account_name = "ccpsazuretf001"
    container_name = "ccpterraformstatefile"
    key = "ccpterraform.tfstate"
  }
}
