module "vault" {
  source                       = "./vault"
  VAULT_TOKEN                  = var.VAULT_TOKEN
  VAULT_ADDR                   = var.VAULT_ADDR
  kv_path                      = var.kv_path
  kv_type                      = var.kv_type
  access_key                   = module.alicloud.access_key
  secert_key                   = module.alicloud.secert_key
  alicloud_secret_path         = var.alicloud_secret_path
  k8s_secret_path              = var.k8s_secret_path
  k8s_cert                     = var.k8s_cert
  k8s_key                      = var.k8s_key
  k8s_host                     = var.k8s_host
  policy_name                  = var.policy_name
  alicloud_secret_capabilities = var.alicloud_secret_capabilities
  k8s_secret_capabilities      = var.k8s_secret_capabilities
  okd_path                     = var.okd_path
  okd_role                     = var.okd_role
  okd_role_policy              = var.okd_role_policy
  okd_role_namespace           = var.okd_role_namespace
  depends_on = [
    module.alicloud
  ]
}

module "alicloud" {
  source       = "./alicloud"
  project_name = var.project_name
  env          = var.env
  region       = var.region
}

module "okd" {
  source                    = "./okd"
  kv_path                   = var.kv_path
  alicloud_secret_path      = var.alicloud_secret_path
  k8s_secret_path           = var.k8s_secret_path
  okd_path                  = var.okd_path
  okd_role                  = var.okd_role
  okd_NAMESPACE             = var.okd_NAMESPACE
  project_name              = var.project_name
  env                       = var.env
  region                    = var.region
  alicloud_log_store_rds    = var.alicloud_log_store_rds
  alicloud_log_store_slb    = var.alicloud_log_store_slb
  alicloud_log_store_mongdb = var.alicloud_log_store_mongdb
  alicloud_log_store_redis  = var.alicloud_log_store_redis
  alicloud_log_store_pod    = var.alicloud_log_store_pod
  secretManagementLogStore  = var.secretManagementLogStore
  crdGroup                  = var.crdGroup
  crdVersion                = var.crdVersion
  crdResource               = var.crdResource
  depends_on = [
    module.vault,
    module.alicloud
  ]
}
module "grafana" {
  source       = "./grafana"
  grafana_url  = var.grafana_url
  grafana_auth = var.grafana_auth
  project_name = var.project_name
  access_key   = module.alicloud.access_key
  secert_key   = module.alicloud.secert_key
  env          = var.env
  region       = var.region
  depends_on = [
    module.alicloud
  ]
}


