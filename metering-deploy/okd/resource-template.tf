
resource "template_dir" "configmap-hcl" {
  source_dir      = "${path.module}/configmap-hcl-template"
  destination_dir = "${path.module}/configmap-hcl"
  vars = {
    kv_path                     = "${var.kv_path}"
    k8s_secret_path             = "${var.k8s_secret_path}"
    alicloud_secret_path        = "${var.alicloud_secret_path}"
    okd_role                    = "${var.okd_role}"
    okd_path                    = "${var.okd_path}"
    alicloud_logservice_project = "${var.project_name}-${var.env}"
    alicloud_oss_bucket         = "metering-report-${var.env}"
    region                      = "${var.region}"
    alicloud_log_store_rds      = "${var.alicloud_log_store_rds}"
    alicloud_log_store_slb      = "${var.alicloud_log_store_slb}"
    alicloud_log_store_mongdb   = "${var.alicloud_log_store_mongdb}"
    alicloud_log_store_redis    = "${var.alicloud_log_store_redis}"
    alicloud_log_store_pod      = "${var.alicloud_log_store_pod}"
    secretManagementLogStore    = "${var.secretManagementLogStore}"
    crdGroup                    = "${var.crdGroup}"
    crdVersion                  = "${var.crdVersion}"
    crdResource                 = "${var.crdResource}"
  }
}
