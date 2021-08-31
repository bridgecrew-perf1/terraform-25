variable "VAULT_TOKEN" {
  type = string
}
variable "VAULT_ADDR" {
  type    = string
  default = "http://127.0.0.1:8200"
}
variable "kv_path" {
  type    = string
  default = "kv"
}
variable "kv_type" {
  type    = string
  default = "kv"
}
variable "alicloud_secret_path" {
  type    = string
  default = "ali_alicloud_credential"
}

variable "k8s_secret_path" {
  type    = string
  default = "ali_k8s_credential"
}
variable "k8s_cert" {
  type    = string
  default = "k8s_cert"
}
variable "k8s_key" {
  type    = string
  default = "k8s_key"
}
variable "k8s_host" {
  type    = string
  default = "k8s_host"
}
variable "policy_name" {
  type    = string
  default = "metering"
}
variable "alicloud_secret_capabilities" {
  type    = string
  default = "[\"read\"]"
}
variable "k8s_secret_capabilities" {
  type    = string
  default = "[\"read\"]"
}
variable "okd_path" {
  type    = string
  default = "okd_auth"
}
variable "okd_role" {
  type    = string
  default = "metering"
}
variable "okd_role_policy" {
  type    = list(any)
  default = ["metering"]
}
variable "okd_role_namespace" {
  type    = list(any)
  default = ["metering"]
}

variable "access_key" {
  type = string
}
variable "secert_key" {
  type = string
}
