module "azurerm_resource_group" {
  source = "../../module/azurerm_resource_group"
  rgs = var.rgs
}

# module "azurerm_storage_account" {
#   source = "../../module/azurerm_storage_account"
#   stgs = var.stgs
  
# }

module "azurerm_storage_account" {
  depends_on = [ module.azurerm_resource_group ]
  source = "../../module/azurerm_storage_account"
  stgs=var.stgs
  
}

module "azurerm_public_ip" {
  depends_on = [ module.azurerm_resource_group ]
  source = "../../module/azurerm_public_ip"
  public_ips=var.public_ips
  
}

module "azurerm_key_vault" {
  depends_on = [ module.azurerm_resource_group ]
  source = "../../module/azurerm_key_vault"
  key_vaults=var.key_vaults
  
}

module "azurerm_kubernetes_cluster" {
  depends_on = [ module.azurerm_resource_group ]
  source = "../../module/azurerm_kubernetes_cluster"
  kubernetes_clusters=var.kubernetes_clusters
  
}

module "azurerm_container_registry" {
  depends_on = [ module.azurerm_kubernetes_cluster ]
  source = "../../module/azurerm_container_registry"
  acr=var.acr
  
}

module "azurerm_mssql_server" {
  depends_on = [ module.azurerm_resource_group ]
  source = "../../module/azurerm_sql_server"
  sql_servers=var.sql_servers
  
}



locals {
  sql_databases = {
    sqldb1 = {
      name      = "mydatabase-dev"
      server_id = module.azurerm_mssql_server.server_id["sql1"]
      tags = {
        Environment = "Dev"
        ManagedBy   = "Terraform"
      }
    }
  }
}

module "azurerm_mssql_database" {
  depends_on    = [module.azurerm_mssql_server]
  source        = "../../module/azurerm_sql_database"
  sql_databases = local.sql_databases
}