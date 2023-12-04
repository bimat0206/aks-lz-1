terraform {
  cloud {
    organization = "terra1test"

    workspaces {
      name = "3-app-aks-1"
    }
  }
  required_providers {
    azuread = {
      source  = "hashicorp/azuread"
      version = ">= 1.0.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.0.0"
    }
  }

}



provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id
}
provider "azuread" {
  use_cli       = false
  client_id     = var.client_id
  client_secret = var.client_secret
  tenant_id     = var.tenant_id
}
