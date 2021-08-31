"auto_auth" = {
  "method" = {
    "config" = {
      "role" = "${okd_role}"
    }
    "type"       = "kubernetes"
    "mount_path" = "auth/${okd_path}"
  }
  "sink" = {
    "config" = {
      "path" = "/home/vault/.token"
    }

    "type" = "file"
  }
}

"exit_after_auth" = true
"pid_file"        = "/home/vault/.pid"

"template" = {
  "contents" = <<EOF
               export RDS_ENDPOINT=rds.aliyuncs.com
               export SLB_ENDPOINT=slb.aliyuncs.com
               export LOG_ENDPOINT=${region}.log.aliyuncs.com
               export LOG_PROJECT=${alicloud_logservice_project}
               export LOG_STORE_RDS=${alicloud_log_store_rds}
               export LOG_STORE_SLB=${alicloud_log_store_slb}
               export LOG_STORE_MONGODB=${alicloud_log_store_mongdb}
               export LOG_STORE_REDIS=${alicloud_log_store_redis}

             {{ with secret "${kv_path}/${alicloud_secret_path}" -}}
               export ACCESS_KEY_ID={{ .Data.AccessKeyID }}
               export ACCESS_KEY_SECRET={{ .Data.AccessKeySecret }}
             {{- end }}

             EOF

  "destination" = "/vault/secrets/config"
}

"vault" = {
  "address" = "http://vault.vault.svc.cluster.local:8200"
}