
resource "vault_mount" "kv" {
  path = var.kv_path
  type = var.kv_type
}


resource "vault_generic_secret" "alicloud_secret" {
  path      = "${var.kv_path}/${var.alicloud_secret_path}"
  data_json = <<EOT
{
  "AccessKeyID":   "${var.access_key}",
  "AccessKeySecret": "${var.secert_key}"
}
EOT
  depends_on = [
    vault_mount.kv
  ]
}

resource "vault_generic_secret" "k8s_secret" {
  path      = "${var.kv_path}/${var.k8s_secret_path}"
  data_json = <<EOT
{
  "client_certificate_data": "${var.k8s_cert}",
  "client_key_data": "${var.k8s_key}",
  "host_url": "${var.k8s_host}"
}
EOT
  depends_on = [
    vault_mount.kv
  ]
}
resource "vault_policy" "policy" {
  name   = var.policy_name
  policy = <<EOT
path "${var.kv_path}/${var.alicloud_secret_path}" {
    capabilities = ${var.alicloud_secret_capabilities}
}
path "${var.kv_path}/${var.k8s_secret_path}" {
    capabilities = ${var.k8s_secret_capabilities}
}
EOT
  depends_on = [
    vault_generic_secret.k8s_secret,
    vault_generic_secret.alicloud_secret
  ]
}
resource "vault_auth_backend" "okd" {
  type = "kubernetes"
  path = var.okd_path
}
resource "vault_kubernetes_auth_backend_config" "okd" {
  backend            = vault_auth_backend.okd.path
  kubernetes_host    = "https://${data.kubernetes_service.apiserver.spec[0].cluster_ip}:${data.kubernetes_service.apiserver.spec[0].port[0].port}"
  kubernetes_ca_cert = data.kubernetes_secret.vault.data["ca.crt"]
  token_reviewer_jwt = data.kubernetes_secret.vault.data["token"]
  depends_on = [
    vault_auth_backend.okd,
    data.kubernetes_service.apiserver,
    data.kubernetes_secret.vault,
    data.kubernetes_secret.vault
  ]
}
resource "vault_kubernetes_auth_backend_role" "okd_role" {
  backend                          = vault_auth_backend.okd.path
  role_name                        = var.okd_role
  token_policies                   = var.okd_role_policy
  bound_service_account_names      = ["*"]
  bound_service_account_namespaces = var.okd_role_namespace
  depends_on = [
    vault_kubernetes_auth_backend_config.okd
  ]
}
