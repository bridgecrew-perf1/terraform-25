resource "random_password" "alicloud_redis_password" {
  length           = 8
  special          = true
  override_special = "!@#$%"
}

resource "alicloud_kvstore_instance" "operator-redis" {
  count = 1
  db_instance_name      = var.alicloud_redis_instance_name
  vswitch_id            = data.alicloud_vswitches.vswitch.vswitches.0.vswitch_id
  security_ips          = ["${data.alicloud_vpcs.vpc.vpcs.0.cidr_block}"]
  instance_type         = "Redis"
  engine_version        = "5.0"
  tags = {
    Created = "Terraform"
  }
  instance_class = "redis.master.small.default"
  depends_on = [
    data.alicloud_vpcs.vpc,
    data.alicloud_vswitches.vswitch
  ]
}

resource "alicloud_kvstore_backup_policy" "operator-redis" {
  count = 1
  instance_id = alicloud_kvstore_instance.operator-redis.0.id
  backup_period = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
  backup_time   = "18:00Z-19:00Z"
  depends_on = [
    alicloud_kvstore_instance.operator-redis
  ]
}

resource "alicloud_kvstore_account" "alerta" {
  instance_id = alicloud_kvstore_instance.operator-redis.0.id
  account_name     = var.alicloud_redis_username
  account_password = random_password.alicloud_redis_password.result
  account_privilege = "RoleReadWrite"
  depends_on = [
    alicloud_kvstore_instance.operator-redis,
    random_password.alicloud_redis_password
  ]
}


output "AMQP_URL" {
  value = "redis://${alicloud_kvstore_account.alerta.account_name}:${alicloud_kvstore_account.alerta.account_password}@${alicloud_kvstore_instance.operator-redis.0.id}:6379"
  sensitive = true
  depends_on = [
    alicloud_kvstore_account.alerta
  ]
}

