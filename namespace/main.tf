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
    key = "ns.tfstate"
  }
}

provider "azurerm" {
  features {}
}
resource "kubernetes_namespace" "leap-task" {
  metadata {
    annotations = {
      name = var.ns_name
    }

    labels = {
      label = "sample-app"
    }

    name = var.ns_name
  }
}
