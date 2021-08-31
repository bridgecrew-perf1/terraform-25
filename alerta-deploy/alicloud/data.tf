data "alicloud_db_instances" "query" {
  engine     = "PostgreSQL"
  name_regex = "operation.*"
}

data "alicloud_vpcs" "vpc" {
  name_regex = ".*operation.*"
}

data "alicloud_vswitches" "vswitch" {
  vpc_id = data.alicloud_vpcs.vpc.vpcs.0.id
  zone_id = var.alicloud_redis_zone_id
  depends_on = [
    data.alicloud_vpcs.vpc
  ]
}
