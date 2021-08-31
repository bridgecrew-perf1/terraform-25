  output "pgm_database" {
    value = module.alicloud.pgm_database
  }
  output "pgm_username" {
    value = module.alicloud.pgm_username
  }
  output "pgm_password" {
    value = module.alicloud.pgm_password
    sensitive = true
  }
  output "pgm_url" {
    value = module.alicloud.pgm_url
  }
  output "AMQP_URL" {
    value = module.alicloud.AMQP_URL
    sensitive = true
  }

  output "pgm_port" {
    value = module.alicloud.pgm_port
    
  }