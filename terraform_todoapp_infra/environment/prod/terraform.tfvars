rgs = {
  rg1 = {
    name       = "rg-prod"
    location   = "centralindia"
    managed_by = "terraform"
    tags = {
      owner       = "Hashicorp"
      environment = "prod"
    }
  }
}

# stgs = {
#   "storage01" = {
#   name                     = "stgstorage01"
#   location                 = "centralindia"
#   resource_group_name      = "rg_dhondhu"
#   account_tier             = "Standard"
#   account_replication_type = "LRS"
#  access_tier = "Hot"


#    tags = {
#       owner       = "Hashicorp"
#       environment = "prod"
#     }
#   }
# }

stgs = {
  storage01 = {
    name                       = "prodstorage01"
    location                   = "Central India"
    resource_group_name        = "rg-prod"
    account_tier               = "Standard"
    account_kind               = "StorageV2"
    account_replication_type   = "LRS"
    access_tier                = "Hot"
    https_traffic_only_enabled = true
    is_hns_enabled             = false
    sftp_enabled               = false
    tags = {
      Environment = "prod"
      Owner       = "prodOpsTeam"
    }
  }

  storage02 = {
    name                     = "prodstorage02"
    location                 = "Central India"
    resource_group_name      = "rg-prod"
    account_tier             = "Premium"
    account_replication_type = "ZRS"
    access_tier              = "Hot"
    tags = {
      Environment = "Prod"
      Owner       = "InfraTeam"
    }
  }
}

public_ips = {
  pip1 = {
    name                    = "prod-public-ip-01"
    resource_group_name     = "rg-prod"
    location                = "Central India"
    allocation_method       = "Static"
    sku                     = "Standard"
    sku_tier                = "Regional"
    ip_version              = "IPv4"
    idle_timeout_in_minutes = 10
    tags = {
      Environment = "prod"
      Owner       = "prodOpsTeam"
    }
  }

  pip2 = {
    name                = "prod-public-ip-02"
    resource_group_name = "rg-prod"
    location            = "Central India"
    allocation_method   = "Static"
    sku                 = "Standard"
    sku_tier            = "Global"
    domain_name_label   = "prodweb01"
    tags = {
      Environment = "Prod"
      Owner       = "InfraTeam"
    }
  }
}

key_vaults = {
  kv1 = {
    kv_name   = "kv-demo-prod01"
    location  = "Central India"
    rg_name   = "rg-prod"
    tenant_id = "41f65365-4083-4b66-9451-eb3d952f7482"
    sku_name  = "standard"
          access_policies = [
        {
          tenant_id          = "41f65365-4083-4b66-9451-eb3d952f7482"
          object_id          = "08f89125-8f27-4c8a-b268-972a8f6e7bfe"
          key_permissions    = ["Get", "List"]
          secret_permissions = ["Get", "Set", "List"]
        }
      ]
    tags = {
      Environment = "prod"
      ManagedBy   = "Terraform"

    }
  }
}

kubernetes_clusters = {
  prod = {
    name                = "aks-prod"
    location            = "Central India"
    resource_group_name = "rg-prod"
    dns_prefix          = "aksprod"
    kubernetes_version  = "1.29.0"
    sku_tier            = "Free"

    default_node_pool = {
      name                = "systempool"
      vm_size             = "Standard_B2s"
      node_count          = 1
      os_disk_size_gb     = 30
      enable_auto_scaling = true
      min_count           = 1
      max_count           = 2
    }

    identity_type = "SystemAssigned"

    network_profile = {
      network_plugin     = "azure"
      network_policy     = "azure"
      dns_service_ip     = "10.0.0.10"
      service_cidr       = "10.0.0.0/16"
      docker_bridge_cidr = "172.17.0.1/16"
    }

    azure_policy_enabled             = true
    private_cluster_enabled          = false
    oidc_issuer_enabled              = true
    open_service_mesh_enabled        = false
    http_application_routing_enabled = false

    tags = {
      Environment = "prod"
      ManagedBy   = "Terraform"
    }
  }

  
}

acr = {
  acr1 = {
    acr_name            = "myacr001"
    resource_group_name = "rg-prod"
    location            = "Central India"
    georeplications = [
      {
        location                = "West Europe"
        zone_redundancy_enabled = true
      tags = {
      Environment = "prod"
      ManagedBy   = "Terraform"
    }
      }
     
    ]
  }
}

sql_servers = {
  sql1 = {
    name                         = "my-sqlserver-prod"
    resource_group_name          = "rg-prod"
    location                     = "Central India"
    administrator_login          = "sqladmin"
    administrator_login_password = "P@ssword123!"
    azuread_administrator = {
      login_username = "wajidali@ashishranjan1077gmail.onmicrosoft.com"
      object_id      = "08f89125-8f27-4c8a-b268-972a8f6e7bfe"
    }
   tags = {
      Environment = "prod"
      ManagedBy   = "Terraform"
    }
  }
}



  


