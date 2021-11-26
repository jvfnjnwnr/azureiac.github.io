data "azurerm_client_config" "current" {}
resource "azurerm_resource_group" "AML" {
    name = "CloudQuickPOCsML-RG"
    location = "West Europe"
}
resource "azurerm_application_insights" "AML" {
    name = "aml-cloudquickpocsappinsight"
    location = azurerm_resource_group.AML.location
    resource_group_name = azurerm_resource_group.AML.name
    application_type = "web"
}
resource "azurerm_key_vault" "AML" {
    name = "cloudquickpocv001"
    location = azurerm_resource_group.AML.location
    resource_group_name = azurerm_resource_group.AML.name
    tenant_id = data.azurerm_client_config.current.tenant_id
    sku_name = "premium"
}
resource "azurerm_storage_account" "AML" {
    name = "cloudquickpocsstga001"
    location = azurerm_resource_group.AML.location
    resource_group_name = azurerm_resource_group.AML.name
    account_tier = "Standard"
    account_replication_type = "GRS"
}

resource "azurerm_machine_learning_workspace" "AML" {
    name = "cloudquickpocs-aml-workspace"
    location = azurerm_resource_group.AML.location
    resource_group_name = azurerm_resource_group.AML.name
    application_insights_id = azurerm_application_insights.AML.id
    key_vault_id = azurerm_key_vault.AML.id
    storage_account_id = azurerm_storage_account.AML.id

    identity {
        type = "SystemAssigned"
    }
}