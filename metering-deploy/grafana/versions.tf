terraform {
required_providers {
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
  }
}
