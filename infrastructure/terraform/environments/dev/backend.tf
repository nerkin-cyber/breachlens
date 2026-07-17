terraform {
  backend "azurerm" {
    resource_group_name  = "rg-breachlens-dev"
    storage_account_name = "stbreachlensdev001"
    container_name       = "tfstate"
    key                  = "dev.terraform.tfstate"

    use_azuread_auth = true
  }
}