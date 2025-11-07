# resource "azurerm_storage_account" "storage_block" {
#   for_each                = var.stgs

#   name                     = each.value.name
#   location                 = each.value.location
#   resource_group_name      = each.value.resource_group_name
#   account_tier             = each.value.account_tier
#   account_replication_type = each.value.account_replication_type
#   access_tier = each.value.access_tier
 

#   tags = each.value.tags
# }


resource "azurerm_storage_account" "storage_block" {
  for_each = var.stgs

  name                          = each.value.name
  resource_group_name           = each.value.resource_group_name
  location                      = each.value.location
  account_kind                  = lookup(each.value, "account_kind", "StorageV2")
  account_tier                  = lookup(each.value, "account_tier", "Standard")
  account_replication_type      = lookup(each.value, "account_replication_type", "LRS")
  access_tier                   = lookup(each.value, "access_tier", "Hot")
  https_traffic_only_enabled    = lookup(each.value, "https_traffic_only_enabled", true)
  min_tls_version               = lookup(each.value, "min_tls_version", "TLS1_2")
  allow_nested_items_to_be_public = lookup(each.value, "allow_nested_items_to_be_public", true)
  shared_access_key_enabled     = lookup(each.value, "shared_access_key_enabled", true)
  public_network_access_enabled = lookup(each.value, "public_network_access_enabled", true)
  large_file_share_enabled      = lookup(each.value, "large_file_share_enabled", false)
  is_hns_enabled                = lookup(each.value, "is_hns_enabled", false)
  sftp_enabled                  = lookup(each.value, "sftp_enabled", false)

  tags = lookup(each.value, "tags", {
    ManagedBy   = "Terraform"
    Environment = "Dev"
  })
}
