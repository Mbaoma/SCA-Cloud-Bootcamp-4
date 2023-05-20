variable "location" {
  default = "Central US"
}

variable "resource-group-name" {
  default = "limpingThropies"
}

variable "storage-account-name" {
  default = "synth3tic9st0rage"
}

variable "storage-account-tier" {
  default = "Standard"
}

variable "storage-account-replication-type" {
  default = "GRS"
}

variable "tag" {
  default = "scaProject"
}

variable "storage-container-name" {
  default = "pulsy7appl35"
}

variable "container_access_type" {
  default = "private"
}

variable "k8s-cluster-name" {
  default = "flying-fortress-cluster"
}

variable "dns-prefix" {
  default = "sca"
}

variable "default-node-pool-name" {
  default = "flying9np"
}

variable "np-vm-vm_size" {
  default = "Standard_D2_v2"
}

variable "np-identity" {
  default = "SystemAssigned"
}


# variable "web-url" {
#   default = "https://sca-webapp.azurewebsites.net"
# }