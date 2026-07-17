locals {
  tags = {
    Application = "BreachLens"
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

module "resource_group" {
  source = "../../modules/resource-group"

  name     = var.resource_group_name
  location = var.location
  tags     = local.tags
}

module "storage" {
  source = "../../modules/storage"

  storage_account_name = var.storage_account_name

  resource_group_name = module.resource_group.name

  location = module.resource_group.location

  tags = local.tags
}

data "azurerm_client_config" "current" {}

module "key_vault" {
  source = "../../modules/key-vault"

  name                = "kv-breachlens-dev"
  location            = var.location
  resource_group_name = module.resource_group.name
  tenant_id           = data.azurerm_client_config.current.tenant_id
}

module "managed_identity" {
  source = "../../modules/managed-identity"

  name                = "id-breachlens-dev"
  resource_group_name = module.resource_group.name
  location            = var.location
}

module "acr" {
  source = "../../modules/acr"

  name                = "acrbreachlensdev"
  resource_group_name = module.resource_group.name
  location            = var.location
}
