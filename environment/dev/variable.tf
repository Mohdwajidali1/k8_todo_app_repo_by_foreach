variable "rgs" {
  type = map(object({
    name        = string
    location    = string
    managed_by  = string
    tags        = map(string)
  }))
}

# variable "stgs" {
#   type = map(object({
#     name = string
#     location=  string
#     resource_group_name= string
#     account_tier=string
#     account_replication_type=string
#     access_tier=string
#     tags=map(string)
#   }))
# }

variable "stgs" {
  description = "Map of storage accounts to create"
  type = map(object({
    name                          = string
    resource_group_name           = string
    location                      = string
    account_kind                  = optional(string)
    account_tier                  = optional(string)
    account_replication_type      = string
    access_tier                   = optional(string)
    https_traffic_only_enabled    = optional(bool)
    min_tls_version               = optional(string)
    allow_nested_items_to_be_public = optional(bool)
    shared_access_key_enabled     = optional(bool)
    public_network_access_enabled = optional(bool)
    large_file_share_enabled      = optional(bool)
    is_hns_enabled                = optional(bool)
    sftp_enabled                  = optional(bool)
    tags                          = optional(map(string))
  }))
}

variable "public_ips" {
  description = "Map of Public IPs to create"
  type = map(object({
    name                        = string
    resource_group_name         = string
    location                    = string
    allocation_method           = string           # Required: Static or Dynamic
    zones                       = optional(list(string))
    ddos_protection_mode        = optional(string)
    ddos_protection_plan_id     = optional(string)
    domain_name_label           = optional(string)
    domain_name_label_scope     = optional(string)
    edge_zone                   = optional(string)
    idle_timeout_in_minutes     = optional(number)
    ip_tags                     = optional(map(string))
    ip_version                  = optional(string)
    public_ip_prefix_id         = optional(string)
    reverse_fqdn                = optional(string)
    sku                         = optional(string)
    sku_tier                    = optional(string)
    tags                        = optional(map(string))
  }))
}

variable "key_vaults" {
  description = "Map of Key Vault configurations"
  type = map(object({
    kv_name                      = string
    location                     = string
    rg_name                      = string
    tenant_id                    = string
    sku_name                     = string
    enabled_for_deployment        = optional(bool)
    enabled_for_disk_encryption   = optional(bool)
    enabled_for_template_deployment = optional(bool)
    rbac_authorization_enabled    = optional(bool)
    purge_protection_enabled      = optional(bool)
    public_network_access_enabled = optional(bool)
    soft_delete_retention_days    = optional(number)
    access_policies = optional(list(object({
      tenant_id               = string
      object_id               = string
      application_id          = optional(string)
      key_permissions         = optional(list(string))
      secret_permissions      = optional(list(string))
      certificate_permissions = optional(list(string))
      storage_permissions     = optional(list(string))
    })))
    network_acls = optional(object({
      bypass                    = string
      default_action             = string
      ip_rules                   = optional(list(string))
      virtual_network_subnet_ids = optional(list(string))
    }))
    tags = optional(map(string))
  }))
}

variable "kubernetes_clusters" {
  description = "Map of AKS cluster configurations"
  type = map(object({
    name                = string
    location            = string
    resource_group_name = string
    dns_prefix          = string
    kubernetes_version  = string
    sku_tier            = string

    default_node_pool = object({
      name                = string
      vm_size             = string
      node_count          = number
      os_disk_size_gb     = number
       min_count           = number
      max_count           = number
    })

    identity_type = string

    network_profile = object({
      network_plugin     = string
      network_policy     = string
      dns_service_ip     = string
      service_cidr       = string
     
    })

    azure_policy_enabled             = bool
    private_cluster_enabled          = bool
    oidc_issuer_enabled              = bool
    open_service_mesh_enabled        = bool
    http_application_routing_enabled = bool

    tags = map(string)
  }))
}



variable "acr" {
  type = map(object({
    acr_name            = string
    resource_group_name = string
    location            = string
    georeplications = list(object({
      location                = string
      zone_redundancy_enabled = bool
      tags                    = map(string)
    }))
  }))
}

variable "sql_servers" {
  type = map(object({
    name                         = string
    resource_group_name          = string
    location                     = string
    administrator_login          = string
    administrator_login_password = string
    azuread_administrator = object({
      login_username = string
      object_id      = string
    })
    tags = map(string)
  }))
}

# variable "sql_databases" {
#   type = map(object({
#     name      = string
#     server_id = string
#     tags      = map(string)
#   }))
  
# }