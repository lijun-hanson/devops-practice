terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.0.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

# Create a resource group
resource "azurerm_resource_group" "terraform" {
  name     = "terraform"
  location = "East US"
}

resource "azurerm_kubernetes_cluster" "terraform-9spokes" {
  name                = "terraform-9spokes"
  location            = azurerm_resource_group.terraform.location
  resource_group_name = azurerm_resource_group.terraform.name
  dns_prefix          = "example"

  default_node_pool {
    name                = "default"
    enable_auto_scaling = true
    vm_size             = "Standard_DS2_v2"
    node_count          = 1
    min_count           = 1
    max_count           = 3
  }

  identity {
    type = "SystemAssigned"
  }
}
