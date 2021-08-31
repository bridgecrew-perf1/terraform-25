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
               export Endpoint=${region}.log.aliyuncs.com
               export Project=${alicloud_logservice_project}
               export podLogStore=${alicloud_log_store_pod}
               export secretManagementLogStore=${secretManagementLogStore}
               export crdGroup=${crdGroup}
               export crdVersion=${crdVersion}
               export crdResource=${crdResource}


             {{ with secret "${kv_path}/${alicloud_secret_path}" -}}
               export AccessKeyID={{ .Data.AccessKeyID }}
               export AccessKeySecret={{ .Data.AccessKeySecret }}
             {{- end }}

             {{ with secret "${kv_path}/${k8s_secret_path}" -}}
               export HOST_URL={{ .Data.host_url }}
               export CERTDATA="{{ .Data.client_certificate_data }}"
               export KEYDATA="{{ .Data.client_key_data }}"
             {{- end }}
             EOF

  "destination" = "/vault/secrets/config"
}

"vault" = {
  "address" = "http://vault.vault.svc.cluster.local:8200"
}