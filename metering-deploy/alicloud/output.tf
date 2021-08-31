
output "access_key" {
  value = alicloud_ram_access_key.secret.id
}
output "secert_key" {
  value     = alicloud_ram_access_key.secret.secret
  sensitive = true
}

output "userid" {
  value     = alicloud_ram_user.user.id
}
