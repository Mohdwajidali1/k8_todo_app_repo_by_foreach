resource "azurerm_container_registry" "acr" {
  for_each = var.acr

  name                = each.value.acr_name
  resource_group_name = each.value.resource_group_name
  location            = each.value.location
  sku                 = "Premium"
  admin_enabled       = false

  dynamic "georeplications" {
    for_each = each.value.georeplications != null ? each.value.georeplications : []

    content {
      location                = georeplications.value.location
      zone_redundancy_enabled = georeplications.value.zone_redundancy_enabled
      tags                    = georeplications.value.tags
    }
  }
}
  


  

