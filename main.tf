locals {
  tags = merge({
    module = "azurerm_storage_account"
  }, var.tags)
}

# Create an Azure Storage Account
resource "azurerm_storage_account" "this" {
  name                     = var.name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_kind             = var.account_kind
  account_replication_type = var.account_replication_type
  account_tier             = var.account_tier
  is_hns_enabled           = var.is_hns_enabled
  sftp_enabled             = var.sftp_enabled

  # Enabling secure transfer
  enable_https_traffic_only = true

  tags = merge({}, local.tags)

  depends_on = [azurerm_resource_group.this]
}

resource "azurerm_storage_account_network_rules" "example" {
  storage_account_id = azurerm_storage_account.this.id
  default_action     = var.network_rules.default_action

  ip_rules                   = lookup(var.network_rules, "ip_rules", [])
  virtual_network_subnet_ids = lookup(var.network_rules, "virtual_network_subnet_ids", [])
  bypass                     = lookup(var.network_rules, "bypass", [])
}

resource "azurerm_storage_data_lake_gen2_filesystem" "example" {
  for_each = var.filesystems

  # Assuming `name` and `storage_account_id` are required attributes for your resource
  name               = each.key
  storage_account_id = azurerm_storage_account.this.id

  dynamic "ace" {
    for_each = each.value.ace != null ? each.value.ace : []
    content {
      scope       = ace.value.scope
      type        = ace.value.type
      id          = ace.value.id
      permissions = ace.value.permissions
    }
  }

  # Using lookup to provide defaults for optional fields
  properties = lookup(each.value, "properties", {})
  owner      = lookup(each.value, "owner", "default_owner")
  group      = lookup(each.value, "group", "default_group")
}

resource "azurerm_storage_container" "this" {
  for_each = var.containers

  name                  = each.key
  storage_account_name  = azurerm_storage_account.this.name
  container_access_type = each.value.container_access_type

  metadata = lookup(each.value, "metadata", {})

}


