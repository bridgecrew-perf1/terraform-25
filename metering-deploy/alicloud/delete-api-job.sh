


aliyun cms DeleteExporterOutput --DestName 'oss-metering-report-'${2}'' --region $1
aliyun cms DeleteExporterRule --RuleName MeteringStorageUtilization-rule --region $1
aliyun cms DeleteExporterRule --RuleName MeteringGetRequest-rule --region $1
aliyun cms DeleteExporterRule --RuleName MeteringPutRequest-rule --region $1
aliyun cms DeleteExporterRule --RuleName InternetSend-rule --region $1

