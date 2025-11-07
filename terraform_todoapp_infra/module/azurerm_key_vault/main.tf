resource "azurerm_key_vault" "kv_block" {
  for_each                    = var.key_vaults
  name                        = each.value.kv_name
  location                    = each.value.location
  resource_group_name         = each.value.rg_name
  tenant_id                   = each.value.tenant_id
  sku_name                    = each.value.sku_name

  enabled_for_deployment        = lookup(each.value, "enabled_for_deployment", false)
  enabled_for_disk_encryption   = lookup(each.value, "enabled_for_disk_encryption", false)
  enabled_for_template_deployment = lookup(each.value, "enabled_for_template_deployment", false)
  rbac_authorization_enabled    = lookup(each.value, "rbac_authorization_enabled", false)
  purge_protection_enabled      = lookup(each.value, "purge_protection_enabled", false)
  public_network_access_enabled = lookup(each.value, "public_network_access_enabled", true)
  soft_delete_retention_days    = lookup(each.value, "soft_delete_retention_days", 90)

  dynamic "access_policy" {
    for_each = lookup(each.value, "access_policies", [])
    content {
      tenant_id               = access_policy.value.tenant_id
      object_id               = access_policy.value.object_id
      application_id          = lookup(access_policy.value, "application_id", null)
      key_permissions         = lookup(access_policy.value, "key_permissions", [])
      secret_permissions      = lookup(access_policy.value, "secret_permissions", [])
      certificate_permissions = lookup(access_policy.value, "certificate_permissions", [])
      storage_permissions     = lookup(access_policy.value, "storage_permissions", [])
    }
  }

  dynamic "network_acls" {
    for_each = lookup(each.value, "network_acls", null) != null ? [each.value.network_acls] : []
    content {
      bypass                     = network_acls.value.bypass
      default_action              = network_acls.value.default_action
      ip_rules                    = lookup(network_acls.value, "ip_rules", [])
      virtual_network_subnet_ids  = lookup(network_acls.value, "virtual_network_subnet_ids", [])
    }
  }

  tags = lookup(each.value, "tags", {})
}