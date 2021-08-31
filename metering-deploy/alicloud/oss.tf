//创建bucket
resource "alicloud_oss_bucket" "bucket-acl" {
  bucket = "metering-report-${var.env}"
  acl    = "private"
}

