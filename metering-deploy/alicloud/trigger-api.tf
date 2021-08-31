resource "null_resource" "create-export" {
  provisioner "local-exec" {
    command     = "bash ${path.module}/create-export.sh"
    environment = {
      ak      = alicloud_ram_access_key.secret.id
      sk      = alicloud_ram_access_key.secret.secret
      userid  = alicloud_ram_user.user.id
      region  = "${var.region}"
      project = "${var.project_name}-${var.env}"
      env = "${var.env}"
    }
  }
  depends_on = [
    alicloud_ram_access_key.secret,
    alicloud_ram_policy.policy,
    alicloud_ram_user_policy_attachment.attach,
    alicloud_ram_access_key.secret,
    alicloud_log_store_index.example
  ]
}

resource "null_resource" "create-export-rule" {
  provisioner "local-exec" {
    command     = "bash -x ${path.module}/create-export-rule.sh"
    environment = {
      region  = "${var.region}"
      env = "${var.env}"
    }
  }
  depends_on = [
    null_resource.create-export
  ]
}


resource "null_resource" "delete-api-job" {
  triggers = {
    region = "${var.region}"
    env = "${var.env}"
  }

  provisioner "local-exec" {
    when    = destroy
    command = "bash -x ${path.module}/delete-api-job.sh  ${self.triggers.region} ${self.triggers.env}   "
  }
  depends_on = [
    alicloud_ram_access_key.secret,
    alicloud_ram_policy.policy,
    alicloud_ram_user_policy_attachment.attach,
    alicloud_ram_access_key.secret,
    alicloud_log_store_index.example
  ]
}


