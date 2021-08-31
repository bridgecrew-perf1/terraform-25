variable "region" {
  type = string
  default = "cn-shanghai"
}

//rds
variable "alicloud_db_name" {
  type = string
  default = "alerta"
}
variable "alicloud_db_username" {
  type = string
  default = "alerta"
}

//redis
variable "alicloud_redis_instance_name" {
  type = string
  default = "operator-redis"
}

variable "alicloud_redis_zone_id" {
  type = string
  default = "cn-shanghai-g"
}

variable "alicloud_redis_username" {
  type = string
  default = "alerta"
}

// okd
variable "okd-namespace" {
  type = string
  default = "alerta"
}

variable "env" {
  type = string
  default = "stage"
}

variable "image-PullPolicy" {
  type = string
  default = "IfNotPresent"
}

variable "image-PullSecrets" {
  type = string
  default = "docker-registry"
}

variable "read-image-registry" {
  type = string
  default = "registry.cn-shanghai.aliyuncs.com/test/alerta-server"
}

variable "read-image-tag" {
  type = string
  default = "0.0.3"
}

variable "write-image-registry" {
  type = string
  default = "registry.cn-shanghai.aliyuncs.com/test/alerta-server"
}

variable "write-image-tag" {
  type = string
  default = "0.0.3"
}

variable "web-image-registry" {
  type = string
  default = "registry.cn-shanghai.aliyuncs.com/test/alerta-ui"
}

variable "web-image-tag" {
  type = string
  default = "0.0.1"
}

variable "route-tls-enable" {
  type = bool
  default = true
}



variable "tls-insecureEdgeTerminationPolicy" {
  type = string
  default = "Redirect"
}

variable "tls-termination" {
  type = string
  default = "edge"
}

variable "tls-cert-path" {
  type = string
  default = "temp-ca.yaml"
}

// serverconfig

variable "ADMIN_USERS" {
  type = list(string)
  default = [
  "admin_user1",
  "admin_user2",
  "admin_tiantian"
  ]
}

variable "COLUMNS" {
  type = list(string)
  default = [
    "severity", 
    "status", 
    "lastReceiveTime", 
    "timeoutLeft", 
    "duplicateCount", 
    "project", 
    "environment", 
    "service", 
    "event", 
    "value",  
    "text"
  ]
}

variable "COLOR_MAP_severity" {
  type = map
  default = {
      "critical": "red",  
      "major": "orange", 
      "minor": "yellow", 
      "warning": "dodgerblue", 
      "info": "green", 
      "unknown": "silver" 
  }
}

variable "ALLOWED_ENVIRONMENTS" {
  type = list(string)
  default = [
    "HSC", 
    "HSDP"
  ]
}

variable "ASI_QUERIES" {
  type = list
  default = [
    {"text": "HSC", "query": [["environment", "HSC"]]}, 
    {"text": "HSDP", "query": [["environment", "HSDP"]]}
  ]
}

variable "SEVERITY_MAP" {
  type = map
  default = {
    "critical": 1, 
    "major": 2, 
    "minor": 3, 
    "warning": 4, 
    "info": 5 
  }
}

variable "AUTH_PROVIDER" {
  type = string
  default = "openid"
}

variable "OIDC_ISSUER_URL" {
  type = string
  default = "https://test.com.cn/auth/realms/master"
}

variable "OAUTH2_CLIENT_ID" {
  type = string
  default = "alerta"
}

variable "OAUTH2_CLIENT_SECRET" {
  type = string
  default = "*****"
}

variable "PLUGINS" {
  type = list
  default = [
    "amqp", 
    "blackout",  
    "dingtalk",  
    "forwarder",  
    "heartbeat",  
    "msteams",  
    "reject",  
    "remote_ip"
  ]
}


//mailerConfig
variable "smtp_host" {
  type = string
  default = "smtpdm.aliyun.com"
}

variable "smtp_port" {
  type = number
  default = 465
}

variable "smtp_password" {
  type = string
  default = "change_me"
}

variable "smtp_starttls" {
  type = bool
  default = false
}

variable "smtp_use_ssl" {
  type = bool
  default = true
}

variable "mail_from" {
  type = string
  default = "no-reply-test@test.com"
}

// mailerRules

variable "mailerRules" {
  type = list
  default = []
}

//teamsRule
variable "msteamsRules" {
  type = list
  default = []
}


//dingRules

variable "dingRules" {
  type = list
  default = []
}

