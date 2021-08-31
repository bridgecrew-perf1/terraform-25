provider "alicloud" {
  region = var.region
}
provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}
provider "template" {
}

provider "local" {
}

provider "random" {
}