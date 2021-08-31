provider "vault" {
  token   = var.VAULT_TOKEN
  address = var.VAULT_ADDR
}
provider "kubernetes" {
  config_path = "~/.kube/config"
}

provider "alicloud" {
  region = var.region
}

provider "grafana" {
  url  = var.grafana_url
  auth = var.grafana_auth
}

provider "template" {
}
provider "null" {
}
provider "local" {
}