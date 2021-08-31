data "local_file" "go-config-init" {
  filename = "${path.module}/configmap-hcl/go-config-init.hcl"
  depends_on = [
    template_dir.configmap-hcl
  ]
}
data "local_file" "go-config" {
  filename = "${path.module}/configmap-hcl/go-config.hcl"
  depends_on = [
    template_dir.configmap-hcl
  ]
}
data "local_file" "python-config-init" {
  filename = "${path.module}/configmap-hcl/python-config-init.hcl"
  depends_on = [
    template_dir.configmap-hcl
  ]
}
data "local_file" "python-config" {
  filename = "${path.module}/configmap-hcl/python-config.hcl"
  depends_on = [
    template_dir.configmap-hcl
  ]
}
data "local_file" "report-config-init" {
  filename = "${path.module}/configmap-hcl/report-config-init.hcl"
  depends_on = [
    template_dir.configmap-hcl
  ]
}
data "local_file" "report-config" {
  filename = "${path.module}/configmap-hcl/report-config.hcl"
  depends_on = [
    template_dir.configmap-hcl
  ]
}
