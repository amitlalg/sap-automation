/*
Description:

  Constraining provider versions
    =    (or no operator): exact version equality
    !=   version not equal
    >    greater than version number
    >=   greater than or equal to version number
    <    less than version number
    <=   less than or equal to version number
    ~>   pessimistic constraint operator, constraining both the oldest and newest version allowed.
           For example, ~> 0.9   is equivalent to >= 0.9,   < 1.0 
                        ~> 0.8.4 is equivalent to >= 0.8.4, < 0.9
*/

data "azurerm_client_config" "current" {

}

provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy               = !var.enable_purge_control_for_keyvaults
      purge_soft_deleted_keys_on_destroy         = !var.enable_purge_control_for_keyvaults
      purge_soft_deleted_secrets_on_destroy      = !var.enable_purge_control_for_keyvaults
      purge_soft_deleted_certificates_on_destroy = !var.enable_purge_control_for_keyvaults
    }
  }
}

provider "azurerm" {
  features {}
  alias                      = "dnsmanagement"
  subscription_id            = try(var.management_dns_subscription_id, null)
  skip_provider_registration = true
}

terraform {
  required_version = ">= 1.0"
  required_providers {
    external = {
      source = "hashicorp/external"
    }
    local = {
      source = "hashicorp/local"
    }
    random = {
      source = "hashicorp/random"
    }
    null = {
      source = "hashicorp/null"
    }
    tls = {
      source = "hashicorp/tls"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}
