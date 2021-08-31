
data "kubernetes_service" "apiserver" {
  metadata {
    name      = "kubernetes"
    namespace = "default"
  }
}

data "kubernetes_service_account" "vault" {
  metadata {
    name      = "vault"
    namespace = "vault"
  }
}

data "kubernetes_secret" "vault" {
  metadata {
    name      = data.kubernetes_service_account.vault.default_secret_name
    namespace = "vault"
  }
}


