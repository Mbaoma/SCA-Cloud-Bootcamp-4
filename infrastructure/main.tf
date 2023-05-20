## Set up a resource group and storage account to use as remote backend
resource "azurerm_resource_group" "storeBackend" {
  name     = var.resource-group-name
  location = var.location
}

resource "azurerm_storage_account" "syntheticStorage" {
  name                     = var.storage-account-name
  resource_group_name      = azurerm_resource_group.storeBackend.name
  location                 = azurerm_resource_group.storeBackend.location
  account_tier             = var.storage-account-tier
  account_replication_type = var.storage-account-replication-type

  tags = {
    name = var.tag
  }
}

resource "azurerm_storage_container" "example" {
  name                  = var.storage-container-name
  storage_account_name  = azurerm_storage_account.syntheticStorage.name
  container_access_type = var.container_access_type
}

# Kubernetes Cluster
resource "azurerm_kubernetes_cluster" "flying-fortress" {
  name                = var.k8s-cluster-name
  location            = azurerm_resource_group.storeBackend.location
  resource_group_name = azurerm_resource_group.storeBackend.name
  dns_prefix          = var.dns-prefix

  default_node_pool {
    name       = var.default-node-pool-name
    node_count = 1
    vm_size    = var.np-vm-vm_size
  }

  identity {
    type = var.np-identity
  }

  tags = {
    name = var.tag
  }
}

#Set DNS zone
# resource "azurerm_dns_zone" "app-url" {
#   name                = var.web-url
#   resource_group_name = azurerm_resource_group.storeBackend.name
# }