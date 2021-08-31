terraform {
  required_version = "1.0.2"
  required_providers {
    alicloud = {
      source  = "aliyun/alicloud"
      version = "1.129.0"
    }
    helm = {
      source = "hashicorp/helm"
      version = "2.2.0"
    }
    template = {
      source = "hashicorp/template"
      version = "2.2.0"
    }
    local = {
      source = "hashicorp/local"
      version = "2.1.0"
    }
    random = {
      source = "hashicorp/random"
      version = "3.1.0"
    }
  }
}
