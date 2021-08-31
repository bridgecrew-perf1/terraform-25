
resource "kubernetes_service_account" "metering" {
  metadata {
    name      = "metering"
    namespace = var.okd_NAMESPACE
  }
}
resource "kubernetes_cluster_role_binding" "metering-view-secretspaces" {
  metadata {
    name = "metering-view-secretspaces"
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "secretspaces.secretmgt.com.cn-v1-view"
  }
  subject {
    kind      = "ServiceAccount"
    name      = "metering"
    namespace = var.okd_NAMESPACE
  }
  depends_on = [
    kubernetes_service_account.metering
  ]
}
resource "kubernetes_cluster_role_binding" "metering-cluster-reader" {
  metadata {
    name = "metering-cluster-reader"
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "cluster-reader"
  }
  subject {
    kind      = "ServiceAccount"
    name      = "metering"
    namespace = var.okd_NAMESPACE
  }
  depends_on = [
    kubernetes_service_account.metering
  ]
}

resource "kubernetes_config_map" "metering-report" {
  metadata {
    name      = "metering-report"
    namespace = var.okd_NAMESPACE
  }
  data = {
    "config-init.hcl" = data.local_file.report-config-init.content
    "config.hcl"      = data.local_file.report-config.content
  }
  depends_on = [
    data.local_file.report-config-init,
    data.local_file.report-config
  ]
}
resource "kubernetes_config_map" "metering-go-data" {
  metadata {
    name      = "metering-go-data"
    namespace = var.okd_NAMESPACE
  }
  data = {
    "config-init.hcl" = data.local_file.go-config-init.content
    "config.hcl"      = data.local_file.go-config.content
  }
  depends_on = [
    data.local_file.go-config-init,
    data.local_file.go-config
  ]
}
resource "kubernetes_config_map" "metering-py-data" {
  metadata {
    name      = "metering-py-data"
    namespace = var.okd_NAMESPACE
  }
  data = {
    "config-init.hcl" = data.local_file.python-config-init.content
    "config.hcl"      = data.local_file.python-config.content
  }
  depends_on = [
    data.local_file.python-config-init,
    data.local_file.python-config
  ]
}

resource "kubernetes_cron_job" "metering-go-data" {
  metadata {
    name      = "metering-go-data"
    namespace = var.okd_NAMESPACE
  }
  spec {
    concurrency_policy = "Allow"
    schedule           = "0 * * * *"
    job_template {
      metadata {}
      spec {
        template {
          metadata {
            annotations = {
              "vault.hashicorp.com/agent-configmap" : "metering-go-data",
              "vault.hashicorp.com/agent-inject" : "true",
              "vault.hashicorp.com/agent-set-security-context" : "false"
            }
          }
          spec {
            container {
              name    = "poddata2service"
              image   = "registry.cn-shanghai.aliyuncs.com/hsc/metering-data:go_0.0.9"
              command = ["sh", "-c"]
              args    = ["source /vault/secrets/config  && ./podData2Service"]
            }
            service_account_name = "metering"
          }
        }
      }
    }
  }
  depends_on = [
    kubernetes_cluster_role_binding.metering-view-secretspaces
  ]
}
resource "kubernetes_cron_job" "metering-py-data" {
  metadata {
    name      = "metering-py-data"
    namespace = var.okd_NAMESPACE
  }
  spec {
    concurrency_policy = "Allow"
    schedule           = "0 * * * *"
    job_template {
      metadata {}
      spec {
        template {
          metadata {
            annotations = {
              "vault.hashicorp.com/agent-configmap" : "metering-py-data",
              "vault.hashicorp.com/agent-inject" : "true",
              "vault.hashicorp.com/agent-set-security-context" : "false"
            }
          }
          spec {
            container {
              name    = "metering-data"
              image   = "registry.cn-shanghai.aliyuncs.com/hsc/metering-data:py_0.0.2"
              command = ["sh", "-c"]
              args    = [". /vault/secrets/config && python main.py"]
            }
          }
        }
      }
    }
  }
}
resource "kubernetes_cron_job" "metering-report" {
  metadata {
    name      = "metering-report"
    namespace = var.okd_NAMESPACE
  }
  spec {
    schedule = "10 2 1 * ?"
    job_template {
      metadata {}
      spec {
        template {
          metadata {
            annotations = {
              "vault.hashicorp.com/agent-configmap" : "metering-report",
              "vault.hashicorp.com/agent-inject" : "true",
              "vault.hashicorp.com/agent-set-security-context" : "false"
            }
          }
          spec {
            container {
              name    = "metering-report"
              image   = "registry.cn-shanghai.aliyuncs.com/hsc/metering-report:0.2.0"
              command = ["sh", "-c"]
              args    = ["source /vault/secrets/config && ./metering-report"]
            }
            service_account_name = "metering"
          }
        }
      }
    }
  }
  depends_on = [
    kubernetes_cluster_role_binding.metering-cluster-reader
  ]
}
