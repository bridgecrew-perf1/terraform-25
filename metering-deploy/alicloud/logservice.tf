

resource "alicloud_log_store" "example" {
  for_each              = toset(["oss", "pod", "slb", "rds", "mongodb", "redis"])
  project               = "${var.project_name}-${var.env}"
  name                  = "${each.key}-metering-data"
  shard_count           = 2
  auto_split            = true
  max_split_shard_count = 64
  append_meta           = true
  retention_period      = 3650
}
resource "alicloud_log_store_index" "example" {
  for_each = toset(["oss", "pod", "slb", "rds", "mongodb", "redis"])
  project  = "${var.project_name}-${var.env}"
  logstore = "${each.key}-metering-data"
  full_text {
    case_sensitive = true
  }
  depends_on = [
    alicloud_log_store.example
  ]
}

