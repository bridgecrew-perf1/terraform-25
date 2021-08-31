//创建用户
resource "alicloud_ram_user" "user" {
  name         = "metering"
  display_name = "system-metering-account"
  comments     = "metering"
  force        = true
}
//分配权限
resource "alicloud_ram_policy" "policy" {
  policy_name     = "terraform-metering"
  policy_document = <<EOF
  {
    "Statement": [
        {
            "Action": "cms:*",
            "Resource": "*",
            "Effect": "Allow"
        },
        {
            "Action": [
                "ecs:DescribeInstances",
                "rds:DescribeDBInstances",
                "slb:DescribeLoadBalancer*",
                "vpc:DescribeEipAddresses",
                "vpc:DescribeRouterInterfaces",
                "vpc:DescribeGlobalAccelerationInstances",
                "vpc:DescribeVpnGateways",
                "vpc:DescribeNatGateways",
                "vpc:DescribeBandwidthPackages",
                "vpc:DescribeCommonBandwidthPackages",
                "oss:ListBuckets",
                "log:ListProject",
                "cdn:DescribeUserDomains",
                "mns:ListQueue",
                "mns:ListTopic",
                "ess:DescribeScalingGroups",
                "ocs:DescribeInstances",
                "kvstore:DescribeInstances",
                "kvstore:DescribeLogicInstanceTopology",
                "hbase:DescribeClusterList",
                "hitsdb:DescribeHiTSDBInstanceList",
                "dds:DescribeDBInstances",
                "petadata:DescribeInstances",
                "petadata:DescribeDatabases",
                "gpdb:DescribeDBInstances",
                "emr:ListClusters",
                "opensearch:ListApps",
                "elasticsearch:ListInstance",
                "mongodb:DescribeDBInstances",
                "rds:DescribeReplicas",
                "CloudAPI:DescribeApis",
                "netgateway:DescribeNatGateways",
                "ddos:DescribeInstancePage",
                "live:DescribeLiveUserDomains",
                "cen:DescribeCens",
                "cen:DescribeCenAttachedChildInstances",
                "kafka:GetKafkaInstanceList",
                "scdn:DescribeScdnUserDomains",
                "dcdn:DescribeDcdnUserDomains",
                "polardb:DescribeDBInstances"
            ],
            "Resource": "*",
            "Effect": "Allow"
        },
        {
            "Action": "ram:CreateServiceLinkedRole",
            "Resource": "*",
            "Effect": "Allow",
            "Condition": {
                "StringEquals": {
                    "ram:ServiceName": "cloudmonitor.aliyuncs.com"
                }
            }
        },
        {
            "Effect": "Allow",
            "Action": "oss:*",
            "Resource": [
                "acs:oss:*:*:metering-report-${var.env}",
                "acs:oss:*:*:metering-report-${var.env}/*"
            ]
        },
        {
            "Action": [
                "oss:Get*",
                "oss:List*"
            ],
            "Effect": "Allow",
            "Resource": "*"
        },
        {
            "Action": "rds:Describe*",
            "Effect": "Allow",
            "Resource": "*"
        },
        {
            "Action": "slb:Describe*",
            "Resource": "*",
            "Effect": "Allow"
        },
        {
            "Action": "cms:QueryMetric*",
            "Resource": "*",
            "Effect": "Allow"
        },
        {
            "Action": "kvstore:Describe*",
            "Resource": "*",
            "Effect": "Allow"
        },
        {
            "Action": "bss:Describe*",
            "Resource": "*",
            "Effect": "Allow"
        },
        {
            "Action": "dds:Describe*",
            "Resource": "*",
            "Effect": "Allow"
        },
        {
            "Action": [
                "vpc:DescribeVpcs",
                "vpc:DescribeVSwitches"
            ],
            "Resource": "*",
            "Effect": "Allow"
        },
        {
            "Action": "log:*",
            "Resource": "*",
            "Effect": "Allow"
        }
    ],
    "Version": "1"
  }
  EOF
  description     = "terraform metering policy"
  force           = true
}
//绑定权限
resource "alicloud_ram_user_policy_attachment" "attach" {
  policy_name = alicloud_ram_policy.policy.name
  policy_type = alicloud_ram_policy.policy.type
  user_name   = alicloud_ram_user.user.name
}
//生成aksk，


resource "alicloud_ram_access_key" "secret" {
  user_name = alicloud_ram_user.user.name

}

