module "alicloud" {
  source = "./alicloud"
  region = var.region
  // postgresql
  alicloud_db_name = var.alicloud_db_name
  alicloud_db_username = var.alicloud_db_username
  // redis
  alicloud_redis_instance_name = var.alicloud_redis_instance_name
  alicloud_redis_zone_id = var.alicloud_redis_zone_id
  alicloud_redis_username = var.alicloud_redis_username
}


module "helm" {
  source       = "./helm"
  okd-namespace = var.okd-namespace
  env = var.env
  image-PullPolicy = var.image-PullPolicy
  image-PullSecrets = var.image-PullSecrets
  read-image-registry = var.read-image-registry
  read-image-tag = var.read-image-tag
  write-image-registry = var.write-image-registry
  write-image-tag = var.write-image-tag
  web-image-registry = var.web-image-registry
  web-image-tag = var.web-image-tag
  route-tls-enable = var.route-tls-enable
  tls-insecureEdgeTerminationPolicy = var.tls-insecureEdgeTerminationPolicy
  tls-termination = var.tls-termination
  tls-cert-path = var.tls-cert-path
  ADMIN_USERS = var.ADMIN_USERS
  COLUMNS = var.COLUMNS
  COLOR_MAP_severity = var.COLOR_MAP_severity
  ALLOWED_ENVIRONMENTS = var.ALLOWED_ENVIRONMENTS
  ASI_QUERIES = var.ASI_QUERIES
  SEVERITY_MAP = var.SEVERITY_MAP
  AUTH_PROVIDER = var.AUTH_PROVIDER
  OIDC_ISSUER_URL = var.OIDC_ISSUER_URL
  OAUTH2_CLIENT_ID = var.OAUTH2_CLIENT_ID
  OAUTH2_CLIENT_SECRET = var.OAUTH2_CLIENT_SECRET
  PLUGINS = var.PLUGINS
  smtp_host = var.smtp_host
  smtp_port = var.smtp_port
  smtp_password = var.smtp_password
  smtp_starttls = var.smtp_starttls
  smtp_use_ssl = var.smtp_use_ssl
  mail_from = var.mail_from
  mailerRules = var.mailerRules
  msteamsRules = var.msteamsRules
  dingRules = var.dingRules
  externalPostgresql_database = module.alicloud.pgm_database
  externalPostgresql_username = module.alicloud.pgm_username
  externalPostgresql-password = module.alicloud.pgm_password
  externalPostgresql_url = "${module.alicloud.pgm_url}:${module.alicloud.pgm_port}"
  AMQP_URL = module.alicloud.AMQP_URL
  
  depends_on = [
    module.alicloud
  ]
}



