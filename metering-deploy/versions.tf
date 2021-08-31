terraform {
  required_version = "1.0.2"

  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.3.2"
    }
    vault = {
      source  = "hashicorp/vault"
      version = "2.21.0"
    }
    alicloud = {
      source  = "aliyun/alicloud"
      version = "1.129.0"
    }
    grafana = {
      source  = "grafana/grafana"
      version = "1.13.2"
    }
    local = {
      source = "hashicorp/local"
      version = "2.1.0"
    }
    null = {
      source = "hashicorp/null"
      version = "3.1.0"
    }
    template = {
      source = "hashicorp/template"
      version = "2.2.0"
    }
  }
}
