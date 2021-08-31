
resource "null_resource" "cgd" {
  provisioner "local-exec" {
    command = "bash -x ${path.module}/create-grafana-datasource.sh"
    environment = {
      ak           = "${var.access_key}"
      sk           = "${var.secert_key}"
      grafana_url  = "${var.grafana_url}"
      grafana_auth = "${var.grafana_auth}"
      region       = "${var.region}"
      project      = "${var.project_name}-${var.env}"
    }
  }
}
resource "grafana_folder" "collection" {
  title = "Metering"
}
resource "grafana_dashboard" "metrics" {
  folder      = grafana_folder.collection.id
  config_json = file("${path.module}/Metering-of-Alicloud-Dashboard.json")
}

resource "null_resource" "delete-grafana-datasource" {
  triggers = {
    grafana_url  = "${var.grafana_url}"
    grafana_auth = "${var.grafana_auth}"
  }

  provisioner "local-exec" {
    when    = destroy
    command = "bash -x ${path.module}/delete-grafana-datasource.sh  ${self.triggers.grafana_url}   ${self.triggers.grafana_auth} "
  }

}
