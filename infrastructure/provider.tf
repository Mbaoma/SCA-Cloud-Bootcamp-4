terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "limpingThropies"
    storage_account_name = "synth3tic9st0rage"
    container_name       = "pulsy7appl35"
    key                  = "backend.tfstate"
  }
}

provider "azurerm" {
  features {}
}