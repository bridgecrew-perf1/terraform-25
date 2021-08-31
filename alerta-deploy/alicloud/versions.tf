terraform {
  required_providers {
    alicloud = {
      source  = "aliyun/alicloud"
      version = "1.129.0"
    }
    random = {
      source = "hashicorp/random"
      version = "3.1.0"
    }
  }
}
