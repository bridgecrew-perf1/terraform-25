data "local_file" "tls-cert" {
  filename = var.tls-cert-path
}

resource "random_id" "mailer-secret-key" {
  byte_length = 20
}

resource "local_file" "values" {
  filename = "${path.module}/helm-value/values.yaml"
  content = templatefile("${path.module}/helm-value-template/values.yaml", {
    image-PullPolicy = var.image-PullPolicy
    image-PullSecrets = var.image-PullSecrets
    okd-namespace = var.okd-namespace
    env = var.env
    read-image-registry = var.read-image-registry
    read-image-tag = var.read-image-tag
    write-image-registry = var.write-image-registry
    write-image-tag = var.write-image-tag
    web-image-registry = var.web-image-registry
    web-image-tag = var.web-image-tag
    route-tls-enable = var.route-tls-enable
    externalPostgresql_database = var.externalPostgresql_database
    externalPostgresql_username = var.externalPostgresql_username
    externalPostgresql_password = urlencode(var.externalPostgresql-password)
    externalPostgresql_url = var.externalPostgresql_url
    tls-insecureEdgeTerminationPolicy = var.tls-insecureEdgeTerminationPolicy
    tls-termination = var.tls-termination
    tls-certificate = replace(yamlencode(data.local_file.tls-cert.content), "|+", "",)
  })
  depends_on = [
    data.local_file.tls-cert
  ]
}

resource "local_file" "serverConfig" {
  filename = "${path.module}/helm-value/serverConfig.yaml"
  content = templatefile("${path.module}/helm-value-template/serverConfig.yaml", {
    ADMIN_USERS =  replace(jsonencode(var.ADMIN_USERS), ",", ", ")
    DASHBOARD_URL = var.route-tls-enable == true ? "https://alerta-web.${var.okd-namespace}.apps.okd-${var.env}.com.cn" : "http://alerta-web.${var.okd-namespace}.apps.okd-${var.env}.com.cn"
    AMQP_URL = var.AMQP_URL
    COLUMNS = replace(jsonencode(var.COLUMNS), ",", ", ")
    COLOR_MAP_severity = replace(replace(jsonencode(var.COLOR_MAP_severity), ",", ", "), ":", ": ")
    ALLOWED_ENVIRONMENTS = replace(jsonencode(var.ALLOWED_ENVIRONMENTS), ",", ", ")
    ASI_QUERIES = replace(jsonencode(var.ASI_QUERIES), ",", ", ")
    SEVERITY_MAP = replace(replace(jsonencode(var.SEVERITY_MAP), ",", ", "), ":", ": ")
    AUTH_PROVIDER = var.AUTH_PROVIDER
    OIDC_ISSUER_URL = var.OIDC_ISSUER_URL
    OAUTH2_CLIENT_ID = var.OAUTH2_CLIENT_ID
    OAUTH2_CLIENT_SECRET = var.OAUTH2_CLIENT_SECRET
    PLUGINS = replace(jsonencode(var.PLUGINS), ",", ", ")

  })
}

resource "local_file" "webConfig" {
  filename = "${path.module}/helm-value/webConfig.yaml"
  content = templatefile("${path.module}/helm-value-template/webConfig.yaml", {
    endpoint = var.route-tls-enable == true ? "https://alerta-read.${var.okd-namespace}.apps.okd-${var.env}.com.cn" : "http://alerta-read.${var.okd-namespace}.apps.okd-${var.env}.com.cn"
  })
}

resource "local_file" "mailerConfig" {
  filename = "${path.module}/helm-value/mailerConfig.yaml"
  content = templatefile("${path.module}/helm-value-template/mailerConfig.yaml", {
    endpoint = var.route-tls-enable == true ? "https://alerta-read.${var.okd-namespace}.apps.okd-${var.env}.com.cn" : "http://alerta-read.${var.okd-namespace}.apps.okd-${var.env}.com.cn"
    secret_key = random_id.mailer-secret-key.hex
    smtp_host = var.smtp_host
    smtp_port = var.smtp_port
    smtp_password = var.smtp_password
    smtp_starttls = title(var.smtp_starttls)
    smtp_use_ssl = title(var.smtp_use_ssl)
    mail_from = var.mail_from
  })
  depends_on = [
    random_id.mailer-secret-key
  ]
}

resource "local_file" "mailerRules" {
  filename = "${path.module}/helm-value/mailerRules.yaml"
  content = templatefile("${path.module}/helm-value-template/mailerRules.yaml", {
    mailerRules = replace(jsonencode(var.mailerRules), ",", ", ")
  })
}

resource "local_file" "msteamsConfig" {
  filename = "${path.module}/helm-value/msteamsConfig.yaml"
  content = templatefile("${path.module}/helm-value-template/msteamsConfig.yaml", {
    msteamsRules = replace(jsonencode(var.msteamsRules), ",", ", ")
  })
}

resource "local_file" "dingRules" {
  filename = "${path.module}/helm-value/dingRules.yaml"
  content = templatefile("${path.module}/helm-value-template/dingRules.yaml", {
    dingRules = replace(jsonencode(var.dingRules), ",", ", ")
  })
}



resource "helm_release" "alerta" {
    force_update = true
    name      = "alerta"
    chart     = "../helm-chart"
    namespace = var.okd-namespace
    values = [
      local_file.values.content,
      local_file.serverConfig.content,
      local_file.webConfig.content,
      local_file.mailerConfig.content,
      local_file.mailerRules.content,
      local_file.msteamsConfig.content,
      local_file.dingRules.content
    ]
  depends_on = [
      local_file.values,
      local_file.serverConfig,
      local_file.webConfig,
      local_file.mailerConfig,
      local_file.mailerRules,
      local_file.msteamsConfig,
      local_file.dingRules
  ]
}


