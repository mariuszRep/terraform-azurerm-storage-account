## general 

variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "tags" {
  type        = map(string)
  description = "Optional tags to add to resources"
  default = {}
}

## azurerm_storage_account
variable "name" {
  type = string
}

variable "account_kind" {
  description = "The kind of storage account to create."
  default     = "StorageV2"
}

variable "account_replication_type" {
  description = "The replication type for the storage account."
  default     = "LRS"
}

variable "account_tier" {
  description = "The storage account tier."
  default     = "Standard"
}

variable "is_hns_enabled" {
  description = "Whether Hierarchical Namespace is enabled."
  default     = true
}

variable "sftp_enabled" {
  description = "Whether SFTP is enabled for the storage accounts."
  type        = bool
  default     = false
}

# vars for azurerm_storage_data_lake_gen2_filesystem
variable "filesystems" {
  type = map(object({
    properties = optional(map(string))
    ace = optional(list(object({
      scope       = optional(string)
      type        = optional(string)
      id          = optional(string)
      permissions = optional(string)
    })))
    owner = optional(string)
    group = optional(string)

  }))
  default = {}
}

variable "containers" {
  description = "A map of container configurations"
  type = map(object({
    container_access_type = string
    metadata              = optional(map(string))
  }))
  default = {}
}

variable "network_rules" {
  description = "Network rules for the storage account"
  type = object({
    default_action             = string
    ip_rules                   = optional(list(string))
    virtual_network_subnet_ids = optional(list(string))
    bypass                     = optional(list(string))
  })
  default = {
    default_action = "Allow"
  }
}




