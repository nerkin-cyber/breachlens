variable "name" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "administrator_login" {
  type = string
}

variable "administrator_password" {
  type      = string
  sensitive = true
}

variable "database_name" {
  type = string
}

variable "sku_name" {
  type    = string
  default = "B_Standard_B1ms"
}

variable "storage_mb" {
  type    = number
  default = 32768
}

variable "tags" {
  type    = map(string)
  default = {}
}