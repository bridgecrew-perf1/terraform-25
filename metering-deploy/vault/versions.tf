terraform {
  required_version = "= 1.0.2"

  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.3.2"
    }
    vault = {
      source  = "hashicorp/vault"
      version = "2.21.0"
    }
    local = {
      source = "hashicorp/local"
      version = "2.1.0"
    }
    null = {
      source = "hashicorp/null"
      version = "3.1.0"
    }
  }
}
