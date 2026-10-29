terraform {
  backend "azurerm" {
    resource_group_name  = "6739-rg-tfstate"
    storage_account_name = "6739sttfstate"
    container_name       = "6739-tfstate"
    key                  = "terraform.tfstate"
    use_azuread_auth     = true
  }
}