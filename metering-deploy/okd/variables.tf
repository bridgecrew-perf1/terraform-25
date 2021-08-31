variable "okd_NAMESPACE" {
  type    = string
  default = "metering"
}
variable "okd_path" {
  type    = string
  default = "okd_auth"
}
variable "okd_role" {
  type    = string
  default = "metering"
}
variable "kv_path" {
  type    = string
  default = "kv"
}
variable "k8s_secret_path" {
  type    = string
  default = "ali_k8s_credential"
}
variable "alicloud_secret_path" {
  type    = string
  default = "ali_alicloud_credential"
}
variable "project_name" {
  type    = string
  default = "test-project-name"
}
variable "alicloud_oss_bucket" {
  type    = string
  default = "metering-report"
}

variable "env" {
  type    = string
  default = "stage"
}
variable "region" {
  type    = string
  default = "cn-shanghai"
}
variable "alicloud_log_store_rds" {
  type    = string
  default = "rds-metering-data"
}
variable "alicloud_log_store_slb" {
  type    = string
  default = "slb-metering-data"
}
variable "alicloud_log_store_mongdb" {
  type    = string
  default = "mongodb-metering-data"
}
variable "alicloud_log_store_redis" {
  type    = string
  default = "redis-metering-data"
}
variable "alicloud_log_store_pod" {
  type    = string
  default = "pod-metering-data"
}
variable "secretManagementLogStore" {
  type    = string
  default = "secret-management-metering-data"
}
variable "crdGroup" {
  type    = string
  default = "secretmgt.com.cn"
}
variable "crdVersion" {
  type    = string
  default = "v1"
}
variable "crdResource" {
  type    = string
  default = "secretspaces"
}
