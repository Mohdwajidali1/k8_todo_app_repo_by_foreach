resource "azurerm_kubernetes_cluster" "aks" {
  for_each = var.kubernetes_clusters

  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  dns_prefix          = each.value.dns_prefix

  kubernetes_version  = each.value.kubernetes_version
  sku_tier            = each.value.sku_tier

  default_node_pool {
    name                = each.value.default_node_pool.name
    vm_size             = each.value.default_node_pool.vm_size
    node_count          = each.value.default_node_pool.node_count
    os_disk_size_gb     = each.value.default_node_pool.os_disk_size_gb
    min_count           = each.value.default_node_pool.min_count
    max_count           = each.value.default_node_pool.max_count
  }

  identity {
    type = each.value.identity_type
  }

  network_profile {
    network_plugin     = each.value.network_profile.network_plugin
    network_policy     = each.value.network_profile.network_policy
    dns_service_ip     = each.value.network_profile.dns_service_ip
    service_cidr       = each.value.network_profile.service_cidr
   
  }

  azure_policy_enabled              = each.value.azure_policy_enabled
  private_cluster_enabled           = each.value.private_cluster_enabled
  oidc_issuer_enabled               = each.value.oidc_issuer_enabled
  open_service_mesh_enabled         = each.value.open_service_mesh_enabled
  http_application_routing_enabled  = each.value.http_application_routing_enabled

  tags = each.value.tags
}