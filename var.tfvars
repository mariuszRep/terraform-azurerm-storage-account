# General configuration variables
resource_group_name = "example-resource-group"
location            = "UK South"
tags = {
  Project     = "Acme Corp"
  Environment = "Development"
}

# Azure Storage Account configuration variables
name = "example102"

filesystems = {
  "filesystem2" = {
    //"ace" = [{}, {}],
    //"properties" = {}, 
    //"group" = null,
    //"owner" = null
  }
}

containers = {
  "container2" = {
    storage_account_name  = "example-account"
    container_access_type = "private"
  }
}

network_rules = {
  default_action              = "Deny"
  ip_rules                    = ["92.24.153.251", "92.24.154.8"]
}