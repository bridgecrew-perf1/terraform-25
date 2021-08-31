
    "auto_auth" = {
      "method" = {
        "config" = {
          "role" = "${okd_role}"
        }
        "type" = "kubernetes"
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
    "pid_file" = "/home/vault/.pid"

    "vault" = {
       "address" = "http://vault.vault.svc.cluster.local:8200"
    }