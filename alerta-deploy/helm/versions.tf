terraform {
  required_providers {
    helm = {
      source = "hashicorp/helm"
      version = "2.2.0"
    }
    local = {
      source = "hashicorp/local"
      version = "2.1.0"
    }
    template = {
      source = "hashicorp/template"
      version = "2.2.0"
    }
    random = {
      source = "hashicorp/random"
      version = "3.1.0"
    }
  }
}
