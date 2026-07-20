locals {
  tags = {
    Application = "BreachLens"
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

module "resource_group" {
  source = "../../modules/resource-group"

  name     = "rg-breachlens-dev"
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

module "log_analytics" {
  source = "../../modules/log-analytics"

  name                = "law-breachlens-dev"
  resource_group_name = module.resource_group.name
  location            = var.location
}

module "application_insights" {
  source = "../../modules/application-insights"

  name                = "appi-breachlens-dev"
  location            = var.location
  resource_group_name = module.resource_group.name

  workspace_id = module.log_analytics.id

  tags = local.tags
}

module "container_app_environment" {
  source = "../../modules/container-app-environment"

  name                = "cae-breachlens-dev"
  location            = var.location
  resource_group_name = module.resource_group.name

  log_analytics_workspace_id = module.log_analytics.id

  tags = local.tags
}

module "postgresql" {
  source = "../../modules/postgresql"

  name                = "psqlbldevcentral01"
  resource_group_name = module.resource_group.name

  location = var.postgres_location

  administrator_login    = "breachlensadmin"
  administrator_password = data.azurerm_key_vault_secret.postgres_admin_password.value

  database_name = "breachlens"

  tags = local.tags
}

data "azurerm_key_vault_secret" "postgres_admin_password" {
  name         = "postgres-admin-password"
  key_vault_id = module.key_vault.id
}