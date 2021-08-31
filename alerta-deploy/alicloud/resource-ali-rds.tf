resource "random_password" "alicloud_db_password" {
  length           = 8
  special          = true
  override_special = "!@#$%"
}

resource "alicloud_db_database" "alerta" {
  count       = 1
  instance_id = data.alicloud_db_instances.query.instances.0.id
  name        = var.alicloud_db_name
  character_set = "UTF8"
  depends_on           = [
    data.alicloud_db_instances.query 
  ]
}

resource "alicloud_db_account" "alerta" {
  db_instance_id     = data.alicloud_db_instances.query.instances.0.id
  account_name       = var.alicloud_db_username
  account_password   = random_password.alicloud_db_password.result
  depends_on           = [
    data.alicloud_db_instances.query,
    random_password.alicloud_db_password
  ]
}

resource "alicloud_db_account_privilege" "alerta" {
  instance_id  = data.alicloud_db_instances.query.instances.0.id
  account_name = alicloud_db_account.alerta.account_name
  privilege    = "DBOwner"
  db_names     = alicloud_db_database.alerta.*.name
  depends_on = [
    alicloud_db_database.alerta,
    alicloud_db_account.alerta
  ]
}




output "pgm_url" {
  value = data.alicloud_db_instances.query.instances.0.connection_string 
}
output "pgm_port" {
  value = data.alicloud_db_instances.query.instances.0.port
}
output "pgm_database" {
  value = alicloud_db_database.alerta.0.name
}
output "pgm_username" {
  value = alicloud_db_account.alerta.account_name
}
output "pgm_password" {
  value     = alicloud_db_account.alerta.account_password
  sensitive = true
}


