resource "random_pet" "prefix" {}

terraform {

  required_version = ">=0.12"

  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "~>2.0"
    }
  }
  backend "azurerm" {
    resource_group_name = "container-rg"
    storage_account_name = "containerstorage28"
    container_name = "tfstate"
    key = "leap.tfstate"
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_kubernetes_cluster" "default" {
  name                = var.cluster_name
  location            = var.location
  resource_group_name = var.rg_name
  dns_prefix          = "${random_pet.prefix.id}-k8s"


  default_node_pool {
    name            = "default"
    node_count      = var.node
    vm_size         = "Standard_D2_v2"
    os_disk_size_gb = 30
  }

  identity {
    type = "SystemAssigned"
  }

  role_based_access_control {
    enabled = true
  }

  tags = {
    createdby = "Shalini"
  }
}

resource "azurerm_container_registry" "acr" {
  name                = var.acr_name
  resource_group_name = var.rg_name
  location            = var.location
  sku                 = "Premium"
  admin_enabled       = true
}
