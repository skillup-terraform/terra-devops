
variable "resource_group_name" {
    type    = string
}

variable "my_location" {
  type    = string
  default = "eastus"
}

variable "disk_name" {
  type        = string
  description = "It is the name of managed disk"
}


variable "disk_size" {
  type    = number
  default = 1
}

variable "public_network_access_enabled" {
  type    = bool
}

variable "vnet_address_space" {
  type = list(string)
  default = ["10.0.0.0/16"]
}


variable "tags" {
  type = map(string)
  default = {
    "environment" = "staging"
    "project_id"  = "xyz0123"
    "project_number" = 1223
  }
}



