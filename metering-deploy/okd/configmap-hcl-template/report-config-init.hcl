"auto_auth" = {
          "method" = {
            "config" = {
              "role" = "${okd_role}"
            }
            "type" = "kubernetes"
            "mount_path" = "auth/${okd_path}"
          }
          "sink" = {
            "config" = {
              "path" = "/home/vault/.token"
            }

            "type" = "file"
          }
        }

        "exit_after_auth" = true
        "pid_file" = "/home/vault/.pid"

        "template" = {
             "contents" = <<EOF
               export LABEL_SELECTOR="kind=customer"
               export LOG_ENDPOINT=http://${region}.log.aliyuncs.com
               export OSS_ENDPOINT=http://oss-${region}.aliyuncs.com
               export LOG_PROJECT_NAME=${alicloud_logservice_project}
               export OSS_BUCKET_NAME=${alicloud_oss_bucket}
               export LOG_TOPIC=""
               export IN_CLUSTER=true
               export LOG_STORE_QUERY='{
                   "pod-metering-data":{
                         "logType":"pod",
                         "project": "name",
                         "instance":"name",
                         "spec":["cpu","memory"],
                         "unit":"hour",
                         "amount":"count",
                         "chargeItem":"pod",
                         "query":"container_name:<$project>* | SELECT  namespace , container_name as name,cpu,memory, count(1) as count group by name, cpu, memory, namespace"
                   },
                   "oss-metering-data":{
                         "logType":"oss",
                         "project": "BucketName",
                         "instance":"BucketName",
                         "unitMap":{
                           "标准存储(本地冗余)容量(MB)":"MB",
                           "外网流出流量(MB)":"MB"
                         },
                          "query":"BucketName:<$project>* |SELECT * , ( SELECT max(Value)/1024/1024 FROM log T1 WHERE T1.cms_metric = '\''MeteringStorageUtilization'\''  and T1.BucketName=T0.BucketName ) AS \"标准存储(本地冗余)容量(MB)\" , ( SELECT sum(T2.Value) FROM log T2 WHERE T2.cms_metric = '\''MeteringGetRequest'\'' and T2.BucketName=T0.BucketName ) AS \"GET请求次数\" , ( SELECT sum(T3.Value) FROM log T3 WHERE T3.cms_metric = '\''MeteringPutRequest'\'' and T3.BucketName=T0.BucketName ) AS \"PUT及其他类型请求次数\" , ( SELECT sum(T5.Value)/1024/1024 FROM log T5 WHERE T5.cms_metric = '\''InternetSend'\'' and T5.BucketName=T0.BucketName) AS \"外网流出流量(MB)\" FROM ( SELECT DISTINCT BucketName FROM log ) T0 GROUP BY BucketName order by BucketName"
                   },
                   "apigateway-metering-data":{
                         "logType":"api",
                         "project": "apiName",
                         "instance": "apiName",
                          "unitMap":{
                            "responseSize":"byte"
                          },
                         "spec":["apiGroupName","instanceId"],
                         "query": "apiName:<$project>*| SELECT apiName, apiGroupName, instanceId, COUNT(1) as count, sum(responseSize) as responseSize GROUP BY apiName, apiGroupName, instanceId"
                   },
                   "mongodb-metering-data":{
                         "logType":"mongodb",
                         "project":"DBInstanceDescription",
                         "instance":"DBInstanceDescription",
                         "spec":["DBInstanceClass","DBInstanceType","ChargeType"],
                         "unit":"hour",
                         "amount":"UsageTime",
                         "chargeItem":"UsageTime",
                         "query":"DBInstanceDescription:<$project>* | SELECT DBInstanceDescription,DBInstanceType,DBInstanceId,DBInstanceClass,DBInstanceStorage,ChargeType,CreationTime,ExpireTime, count(1) as UsageTime group by DBInstanceDescription,DBInstanceType,DBInstanceId,DBInstanceClass,DBInstanceStorage,ChargeType,CreationTime,ExpireTime"
                   },
                   "rds-metering-data":{
                         "logType":"rds",
                         "project":"dbinstancedescription",
                         "instance":"dbinstancedescription",
                         "spec":["dbinstanceclass","paytype","engine"],
                         "unit":"hour",
                         "amount":"usageTime",
                         "chargeItem":"UsageTime",
                         "query":"dbinstancedescription:<$project>*  | SELECT dbinstancedescription, dbinstanceclass, dbinstancestorage, paytype, engine, count(1) as usageTime GROUP BY dbinstancedescription, dbinstanceclass, dbinstancestorage, paytype, engine"
                   },
                   "slb-metering-data":{
                        "logType":"slb",
                        "project":"loadBalancerName",
                        "instance":"loadBalancerName",
                        "chargeItems":["InstanceRent(用量)","实例规格(用量)","Bandwidth","traffic"],
                        "spec":["loadBalancerSpec","PayType","InternetChargeType"],
                          "unitMap":{
                            "traffic":"GB"
                          },
                          "query":"loadBalancerName:<$project>*|SELECT loadBalancerName ,InternetChargeType, PayType, Bandwidth, loadBalancerSpec , COUNT(1) AS \"InstanceRent(用量)\", COUNT(1) AS \"实例规格(用量)\" , sum(NetworkOut) / 1024 / 1024 / 1024 AS traffic FROM log t1  GROUP BY loadBalancerName, loadBalancerSpec, NetworkOut, PayType, Bandwidth, InternetChargeType ORDER BY loadBalancerName"
                   },
                   "redis-metering-data":{
                        "logType":"redis",
                        "project":"InstanceName",
                        "instance":"InstanceId",
                        "chargeItem":"usageTime",
                        "spec":["InstanceId","InstanceClass"],
                        "unit":"hour",
                        "query":"InstanceName:<$project>* |  SELECT  InstanceName,InstanceId, InstanceClass , max(Bandwidth) as bandwidth , DefaultBandWidth , count(1) as count group by InstanceName , InstanceId,InstanceClass,Bandwidth, DefaultBandWidth"
                   }
               }'

             {{ with secret "${kv_path}/${alicloud_secret_path}" -}}
               export LOG_AK_ID={{ .Data.AccessKeyID }}
               export LOG_AK_SECRET={{ .Data.AccessKeySecret }}
             {{- end }}
             {{ with secret "${kv_path}/${alicloud_secret_path}" -}}
               export OSS_AK_ID={{ .Data.AccessKeyID }}
               export OSS_AK_SECRET={{ .Data.AccessKeySecret }}
             {{- end }}

             EOF

             "destination" = "/vault/secrets/config"
           }

        "vault" = {
          "address" = "http://vault.vault.svc.cluster.local:8200"
        }
