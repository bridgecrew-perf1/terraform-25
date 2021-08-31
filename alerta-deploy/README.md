## Prepare

#### Install the required components

| name | Install Document | version |
|---|---|---|
| `terraform` |https://learn.hashicorp.com/tutorials/terraform/install-cli | ~> v1.0.2 |
| `oc` |https://docs.okd.io/latest/cli_reference/openshift_cli/getting-started-cli.html#cli-installing-cli_cli-developer-commands | ~> 4.2 |


#### create okd namespace & create default pull secert

![avatar](picture/create-okd-namespaces.png)

###### default pull secert name is ${`image-PullSecrets`}
![avatar](picture/create-pull-secerts.png)
#### Prepare OKD  Login  token 

example:
```
oc login --token=sha256~EC.......U --server=https://api.*******:6443
```

#### Prepare alicloud access_key & access_key

```txt
This user needs to have the AliyunFullAccess permissions
```

#### Prepare Alicloud RDS Instance

##### `create-alicloud-rds`
![avatar](picture/create-alicloud-rds.png)
##### `change-alicloud-rds-name`; rds name: `operation` 
![avatar](picture/change-alicloud-rds-name.png)
##### `update-rds-security-group`
![avatar](picture/update-rds-security-group.png)


#### Prepare keycloak client & user
##### `["client", "client secert", "username"]`

##### `create-keycloak-client`
![avatar](picture/create-keycloak-client-alerta-1.png)
![avatar](picture/create-keycloak-client-alerta-2.png)
##### `get-keycloak-client-secert`
![avatar](picture/get-keycloak-client-alerta-secert.png)
##### `create-keycloak-user`
![avatar](picture/create-keycloak-alerta-user.png)
![avatar](picture/create-keycloak-alerta-user-2.png)

#### If you enable tls, you need to prepare a tls cert file 
##### `file path is ${tls-cert-path}` ; file context example

``` yaml
certificate: |
  -----BEGIN CERTIFICATE-----
  MIIFZTCCBE2gAwIBAgISBFGOCI64BiicsgGrvRtfFR/qMA0GCSqGSIb3DQEBCwUA
  MDIxCzAJBgNVBAYTAlVTMRYwFAYDVQQKEw1MZXQncyBFbmNyeXB0MQswCQYDVQQD
  EwJSMzAeFw0yMTAyMTkwNjAwMjhaFw0yMTA1MjAwNjAwMjhaMDsxOTA3BgNVBAMM
  MCouYXBwcy5va2Qtc3RhZ2UucGhpbGlwcy1oZWFsdGhzdWl0ZWNoaW5hLmNvbS5j
  bjCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAL7bczKqkXTrJ4v3dN9Q
  +rJ150kVwDC/z09JvT5lDqwUw3GkTlrgo+4OkYtAf6izLb5k0wv/uZtVpmscj2bi
  75VFnts425p4Kh4PRPNY01UalZOFGWXt6s2dm0FrT/gA6jJQDt7hjhIRgjXR/3yX
  Cnlp5PFUqHQzX9GZNgeI+dcP/YLxU/msP79XoGC58EkAMYO5IdirYoqluxTFJUkX
  xqG0QmMY6QXJip5VIUO0szXenHt7ixqnEgRvN1sWzSsOfGajDL/S0jkxUMCjba7r
  u0EuTj8FO5Td22SBSTEMWjaIy5OFKUUMjPWjKuZC9epU5E0al9y2SyNs2ZALwXgd
  EIkCAwEAAaOCAmowggJmMA4GA1UdDwEB/wQEAwIFoDAdBgNVHSUEFjAUBggrBgEF
  BQcDAQYIKwYBBQUHAwIwDAYDVR0TAQH/BAIwADAdBgNVHQ4EFgQUAYMA+0OHAquV
  0uChKaD4cCvzigMwHwYDVR0jBBgwFoAUFC6zF7dYVsuuUAlA5h+vnYsUwsYwVQYI
  KwYBBQUHAQEESTBHMCEGCCsGAQUFBzABhhVodHRwOi8vcjMuby5sZW5jci5vcmcw
  IgYIKwYBBQUHMAKGFmh0dHA6Ly9yMy5pLmxlbmNyLm9yZy8wOwYDVR0RBDQwMoIw
  Ki5hcHBzLm9rZC1zdGFnZS5waGlsaXBzLWhlYWx0aHN1aXRlY2hpbmEuY29tLmNu
  MEwGA1UdIARFMEMwCAYGZ4EMAQIBMDcGCysGAQQBgt8TAQEBMCgwJgYIKwYBBQUH
  AgEWGmh0dHA6Ly9jcHMubGV0c2VuY3J5cHQub3JnMIIBAwYKKwYBBAHWeQIEAgSB
  9ASB8QDvAHYARJRlLrDuzq/EQAfYqP4owNrmgr7YyzG1P9MzlrW2gagAAAF3uRb/
  VwAABAMARzBFAiAQ8VXXQJgEYNWooS1qJsmc1nGb4ALJly+BxCLRhbbqwAIhAKh8
  PdqwvFYQ6Ql6172YGXjHGcJa9RO5fA6xJdWmRNTuAHUA9lyUL9F3MCIUVBgIMJRW
  juNNExkzv98MLyALzE7xZOMAAAF3uRb/PgAABAMARjBEAiAT04s8+rFC/dfD58PT
  DFyxThw5oi8MesRymbNZw8ZYpQIgZJphg4M3GXlqWD74zsks/Hs1wOyCblkR9yAW
  xrhCJTAwDQYJKoZIhvcNAQELBQADggEBAFMZ+mTYseIqFVw11ywiV0WrZpuOzE9H
  Ew/ShpOpGpcb6bStMRddfdgB72vjh2tnJ0GuyoujlR4INJcKM7moQXKFqayW6rDN
  Oy/xmah0ImtxdGSMPN6b50ZES/2k+gX5XLjTz0NEHG+2dp5DK0iPz3pvuKIk4LFx
  mdMXsJuMApr3pvrkqni/ZaLk2PtZRrkNTPDV8j2+AgIVy1Fereu9mhxBZZHn5XYH
  yoC6byAizydC3LMGkoxG9OYcqh6jqgEztqxeagARtrqTNr2mjcLFv0mJJvMX2aUV
  RW/Eoz/sK49IATLkADwAELqsthWAeYmD56Ocm9eh+zCsz5fIPWM9/Vc=
  -----END CERTIFICATE-----
key: |
  -----BEGIN RSA PRIVATE KEY-----
  MIIEowIBAAKCAQEAvttzMqqRdOsni/d031D6snXnSRXAML/PT0m9PmUOrBTDcaRO
  WuCj7g6Ri0B/qLMtvmTTC/+5m1WmaxyPZuLvlUWe2zjbmngqHg9E81jTVRqVk4UZ
  Ze3qzZ2bQWtP+ADqMlAO3uGOEhGCNdH/fJcKeWnk8VSodDNf0Zk2B4j51w/9gvFT
  +aw/v1egYLnwSQAxg7kh2KtiiqW7FMUlSRfGobRCYxjpBcmKnlUhQ7SzNd6ce3uL
  GqcSBG83WxbNKw58ZqMMv9LSOTFQwKNtruu7QS5OPwU7lN3bZIFJMQxaNojLk4Up
  RQyM9aMq5kL16lTkTRqX3LZLI2zZkAvBeB0QiQIDAQABAoIBAQCpWn7w4WtqjNMt
  nqmlEu0xd+9/6X39g+YHnA4BlJidV1tJtpsUhqrPrTu2jcf5QO0BOeQPjJ382NZv
  ywrwJ8Sh9wIL0nsCqUfuHmx3ZkU4CfvZx8wOpzunsgc22GtATEeD14gqe4iePc0F
  xs5mlnvj2nQdNJq5aXDHwqSvsPrIuk2N7VHEW+/QaZe2QiZShnT6upekByaHm9z1
  7GL/hbE0u9MNaKSTUupM4dT6qpRe7l6+UloLpn/qbkQJx8lRckJgf/OQuUZb8LoC
  CSSMXr0+Sub7ZzQ7r7WmJfa1ZpJc3yQqXboRev/LVp4k4Y5mVp0JFe7l1hA1PS84
  7NZ0FXkBAoGBAOuKULtB6pU09jIRJ+DrLiNcSCXQ1p/5lDpf2Z2fgZqFRWJT3wN6
  ZRb+Wrd0l8gPp+yltoClaZLHjDgjpCu1JCXAh3AOSh/qNaz6MjQIDX4ub0XlRdHS
  BUNw3rim3e98nLGVCbbRFtRZgXRkNCItKeEPo5whvhZM6BJFO/2LME7pAoGBAM9v
  haAwkR0flPd4X/3RASpKv6v957Rdxb49yETQ1DoFJBrqZPsaJOYnJqSDqnqzvq9S
  Q0+2i062gUQ3VqeHunzP+t5OFcOXLahVHKS+7d4142A1PDZPFQnWNCiW6CMa8JCw
  FZHllrCnVnvwcaRAyevBe14zB8f3X/PEWMJwGfChAoGADklCYkk6ODiRIjJGL+8z
  yjNDsP98tRFHO08q/NN64etpbPBXW3emAAIHcI8i0aCZd9IJQr5FrABscc8/muMO
  wTdvP42uU0c6YDaAqwU+BEQ+vYeNd498gD2tVJfSaD8vpdm7UBpYfyK6pluZieUh
  YCQ5sTOeuu2JOep3HAbANFkCgYAR58V4C1krU2OPbPOUPCtGlEcxOGx8tC9yeXDF
  B+WZ0IHKVPs8dYhD2ZNLVhYsG0HVbltjERW7SKOl2MUBFwUw6t7zu3fDd1Q4mIgt
  bFGqAarLziyRX4goXjYIXuZQyW2Ef76M5m14eClN73ZPwEvtrrjQa8U7LI46w3MJ
  7ZU/oQKBgDsbJPOOvbIvBjFRu/qRvySyT831MyQTqax0D4l3ZND+Sz0Lvm9APD4y
  JxIUIHYCPHjdXFsHNM9ZTO1xv7zoPYKobbLp8o5eoOoGTq8qG3/O9lyh3RZYGAWc
  urAtbsnZBqMMKNYQJhEkJxd96ST3PluY6x3J1sG/c5anTGk5ePM7
  -----END RSA PRIVATE KEY-----
caCertificate: |
  -----BEGIN CERTIFICATE-----
  MIIEZTCCA02gAwIBAgIQQAF1BIMUpMghjISpDBbN3zANBgkqhkiG9w0BAQsFADA/
  MSQwIgYDVQQKExtEaWdpdGFsIFNpZ25hdHVyZSBUcnVzdCBDby4xFzAVBgNVBAMT
  DkRTVCBSb290IENBIFgzMB4XDTIwMTAwNzE5MjE0MFoXDTIxMDkyOTE5MjE0MFow
  MjELMAkGA1UEBhMCVVMxFjAUBgNVBAoTDUxldCdzIEVuY3J5cHQxCzAJBgNVBAMT
  AlIzMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAuwIVKMz2oJTTDxLs
  jVWSw/iC8ZmmekKIp10mqrUrucVMsa+Oa/l1yKPXD0eUFFU1V4yeqKI5GfWCPEKp
  Tm71O8Mu243AsFzzWTjn7c9p8FoLG77AlCQlh/o3cbMT5xys4Zvv2+Q7RVJFlqnB
  U840yFLuta7tj95gcOKlVKu2bQ6XpUA0ayvTvGbrZjR8+muLj1cpmfgwF126cm/7
  gcWt0oZYPRfH5wm78Sv3htzB2nFd1EbjzK0lwYi8YGd1ZrPxGPeiXOZT/zqItkel
  /xMY6pgJdz+dU/nPAeX1pnAXFK9jpP+Zs5Od3FOnBv5IhR2haa4ldbsTzFID9e1R
  oYvbFQIDAQABo4IBaDCCAWQwEgYDVR0TAQH/BAgwBgEB/wIBADAOBgNVHQ8BAf8E
  BAMCAYYwSwYIKwYBBQUHAQEEPzA9MDsGCCsGAQUFBzAChi9odHRwOi8vYXBwcy5p
  ZGVudHJ1c3QuY29tL3Jvb3RzL2RzdHJvb3RjYXgzLnA3YzAfBgNVHSMEGDAWgBTE
  p7Gkeyxx+tvhS5B1/8QVYIWJEDBUBgNVHSAETTBLMAgGBmeBDAECATA/BgsrBgEE
  AYLfEwEBATAwMC4GCCsGAQUFBwIBFiJodHRwOi8vY3BzLnJvb3QteDEubGV0c2Vu
  Y3J5cHQub3JnMDwGA1UdHwQ1MDMwMaAvoC2GK2h0dHA6Ly9jcmwuaWRlbnRydXN0
  LmNvbS9EU1RST09UQ0FYM0NSTC5jcmwwHQYDVR0OBBYEFBQusxe3WFbLrlAJQOYf
  r52LFMLGMB0GA1UdJQQWMBQGCCsGAQUFBwMBBggrBgEFBQcDAjANBgkqhkiG9w0B
  AQsFAAOCAQEA2UzgyfWEiDcx27sT4rP8i2tiEmxYt0l+PAK3qB8oYevO4C5z70kH
  ejWEHx2taPDY/laBL21/WKZuNTYQHHPD5b1tXgHXbnL7KqC401dk5VvCadTQsvd8
  S8MXjohyc9z9/G2948kLjmE6Flh9dDYrVYA9x2O+hEPGOaEOa1eePynBgPayvUfL
  qjBstzLhWVQLGAkXXmNs+5ZnPBxzDJOLxhF2JIbeQAcH5H0tZrUlo5ZYyOqA7s9p
  O5b85o3AM/OJ+CktFBQtfvBhcJVd9wvlwPsk+uyOy2HI7mNxKKgsBTt375teA2Tw
  UdHkhVNcsAKX1H7GNNLOEADksd86wuoXvg==
  -----END CERTIFICATE-----



```


#### Prepare terraform.tfvars  to current directory

###### terraform.tfvars example

```
okd-namespace = "test-alerta"
ADMIN_USERS = [ "admin_user1", "admin_user2", "admin_tiantian" ]
COLUMNS = [ "severity", "status", "lastReceiveTime", "timeoutLeft", "duplicateCount", "project", "environment", "service", "event", "value",  "text" ]
COLOR_MAP_severity = { "critical": "red", "major": "orange", "minor": "yellow", "warning": "dodgerblue", "info": "green", "unknown": "silver" } 
OIDC_ISSUER_URL = "https://******/auth/realms/master"
OAUTH2_CLIENT_ID = "alerta"
OAUTH2_CLIENT_SECRET = "************"

```

###### terraform.tfvars Configuration

| Parameter | Description | Default| is_Required|
|---|---|---|--- |
| `region` | alicloud create log_project region| `cn-shanghai`| False  |
| `okd-namespace` | deploy okd namespace |`alerta` | False |
| `env` | deploy  environment : stage, pre, prod | `stage` | False |
| `alicloud_db_name` | alicloud create  database is `alicloud_db_name` in rds instance | `alerta` | False |
| `alicloud_db_username ` |   alicloud create database user `alicloud_db_username` for database  `alicloud_db_name` | `alerta` | False |
| `alicloud_redis_instance_name` | alicloud create redis instance name is `alicloud_redis_instance_name` | `*****-operator-redis`   | False |
| `alicloud_redis_zone_id` | alicloud redis instance zone id  | `cn-shanghai-g`   | False |
| `alicloud_redis_username` | alicloud redis `alicloud_redis_instance_name` username | `alerta`   | False |
| `image-PullPolicy` |pod image PullPolicy |`IfNotPresent` | False  |
| `image-PullSecrets` | pod  image-PullSecrets |`docker-registry`  |False   |
| `read-image-registry` |read-image-registry|`registry.cn-shanghai.aliyuncs.com/*****/alerta-server`  |False|
| `read-image-tag` |read-image-tag|`0.0.3` | False  |
| `write-image-registry` |write-image-registry|`registry.cn-shanghai.aliyuncs.com/*****/alerta-server` | False |
| `write-image-tag` |write-image-tag|`0.0.3` | False  |
| `web-image-registry` |web-image-registry|`registry.cn-shanghai.aliyuncs.com/*****/alerta-ui` | False |
| `web-image-tag` |web-image-tag|`0.0.1` | False  |
| `route-tls-enable` | route-tls-enable| `true`| False |
| `tls-insecureEdgeTerminationPolicy` | tls-insecureEdgeTerminationPolicy | `Redirect`| False |
| `tls-termination` | tls-termination | `edge`| False |
| `tls-cert-path` | tls-cert-path | `temp-ca.yaml`|  False |
| `ADMIN_USERS` | keycloak ADMIN_USERS name  list  | `[ "admin_leonj", "rylandc", "admin_tiantian" ]`| False |
| `COLUMNS` | COLUMNS list  | `[ "severity", "status", "lastReceiveTime", "timeoutLeft", "duplicateCount", "project", "environment", "service", "event", "value",  "text" ]`| False |
| `COLOR_MAP_severity` | COLOR_MAP_severity | `{ "critical": "red", "major": "orange", "minor": "yellow", "warning": "dodgerblue", "info": "green", "unknown": "silver" }`| False |
| `ALLOWED_ENVIRONMENTS` |ALLOWED_ENVIRONMENTS | `[ "HSC", "HSDP" ]`| False |
| `ASI_QUERIES` | ASI_QUERIES | `[ {"text": "HSC", "query": [["environment", "HSC"]]},  {"text": "HSDP", "query": [["environment", "HSDP"]]} ]`| False |
| `SEVERITY_MAP` | SEVERITY_MAP | `{ "critical": 1, "major": 2, "minor": 3, "warning": 4, "info": 5 }`| False |
| `AUTH_PROVIDER` | AUTH_PROVIDER | `openid`| False |
| `OIDC_ISSUER_URL` | OIDC_ISSUER_URL | `https://*****/auth/realms/master`| True |
| `OAUTH2_CLIENT_ID` | OAUTH2_CLIENT_ID | `alerta`| True |
| `OAUTH2_CLIENT_SECRET` | OAUTH2_CLIENT_SECRET | `c3560a46-7eb7-4575-93c9-93c06ba62ce5` | True |
| `PLUGINS` | PLUGINS | `[ "amqp", "blackout",  "dingtalk",  "forwarder",  "heartbeat",  "msteams", "reject", "remote_ip" ]`| False |
| `smtp_host` | smtp_host | `smtpdm.aliyun.com`| False |
| `smtp_port` | smtp_port | `465`| False |
| `smtp_password` | smtp_password | `change_me`| False |
| `smtp_starttls` | smtp_starttls | `false`| False |
| `smtp_use_ssl` | smtp_use_ssl | `true`| False |
| `mail_from` | mail_from | `no-reply-test@*****.com`| False |
| `mailerRules` | mailerRules | `[]`| False |
| `msteamsRules` | msteamsRules | `[]`| False  |
| `dingRules` | dingRules | `[]`| False |

#### Prepare backend.tf to current directory
###### prepare backend oss & oss dir


```
terraform {
  backend "oss" {
    bucket = "terraform-backend"  // backend oss name 
    prefix = "alerta"   // backend oss dir 
    region = "cn-shanghai" // backend oss region
  }
}

```

## Install

```bash
# login okd cluser
oc login --token=sha256~EC.......U --server=https://api.*******:6443

# export alicloud aksk
export ALICLOUD_ACCESS_KEY=......
export ALICLOUD_SECRET_KEY=......

### terraform init in MACOS
unzip providers-linux.zip
terraform init  -plugin-dir providers-macos 

### terraform init in Linux
unzip providers-linux.zip
terraform init  -plugin-dir providers-linux


# try-run
terraform plan  --var-file terraform.tfvars

# install
terraform apply -auto-approve  --var-file terraform.tfvars
```

## destroy

```bash

# login okd cluser
oc login --token=sha256~EC.......U --server=https://api.*******:6443


# export alicloud aksk
export ALICLOUD_ACCESS_KEY=......
export ALICLOUD_SECRET_KEY=......

# destroy
terraform destroy -auto-approve  --var-file terraform.tfvars
```
