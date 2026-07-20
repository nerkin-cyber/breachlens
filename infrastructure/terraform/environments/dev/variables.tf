# variable "subscription_id" {
#   description = "Azure Subscription ID"
#   type        = string
# }

variable "location" {
  description = "Azure Region"
  type        = string
  default     = "eastus2"
}

variable "environment" {
  description = "Environment"
  type        = string
  default     = "dev"
}

variable "storage_account_name" {
  type    = string
  default = "stbreachlensdev001"
}

variable "postgres_location" {
  description = "Azure region for PostgreSQL"
  type        = string
  default     = "centralus"
}