

variable "okd-namespace" {
  type = string
}

variable "env" {
  type = string
}

variable "image-PullPolicy" {
  type = string
}

variable "image-PullSecrets" {
  type = string
}

variable "read-image-registry" {
  type = string
}

variable "read-image-tag" {
  type = string
}

variable "write-image-registry" {
  type = string
}

variable "write-image-tag" {
  type = string
}

variable "web-image-registry" {
  type = string
}

variable "web-image-tag" {
  type = string
}


variable "route-tls-enable" {
  type = bool
}



variable "tls-insecureEdgeTerminationPolicy" {
  type = string
}

variable "tls-termination" {
  type = string
}

variable "tls-cert-path" {
  type = string
}

// serverconfig

variable "ADMIN_USERS" {
  type = list(string)
}

variable "COLUMNS" {
  type = list(string)
}

variable "COLOR_MAP_severity" {
  type = map
}

variable "ALLOWED_ENVIRONMENTS" {
  type = list(string)
}

variable "ASI_QUERIES" {
  type = list
}

variable "SEVERITY_MAP" {
  type = map
}

variable "AUTH_PROVIDER" {
  type = string 
}

variable "OIDC_ISSUER_URL" {
  type = string
}

variable "OAUTH2_CLIENT_ID" {
  type = string
}

variable "OAUTH2_CLIENT_SECRET" {
  type = string
}

variable "PLUGINS" {
  type = list
}


//mailerConfig
variable "smtp_host" {
  type = string
}

variable "smtp_port" {
  type = number
}

variable "smtp_password" {
  type = string
}

variable "smtp_starttls" {
  type = bool
}

variable "smtp_use_ssl" {
  type = bool
}

variable "mail_from" {
  type = string
}

// mailerRules

variable "mailerRules" {
  type = list
}

//teamsRule
variable "msteamsRules" {
  type = list
}


//dingRules

variable "dingRules" {
  type = list
}

variable "externalPostgresql_database" {
  type = string
}
variable "externalPostgresql_username" {
  type = string
}
variable "externalPostgresql-password" {
  type = string
}

variable "externalPostgresql_url" {
  type = string
}

variable "AMQP_URL" {
  type = string
}
