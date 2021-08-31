#!/bin/bash



for i in oss pod slb rds mongodb redis apigateway
do
curl  --request POST "$grafana_url/api/datasources"\
    --header "Authorization: Bearer $grafana_auth" \
    --header 'Accept: application/json' \
    --header 'Content-Type: application/json' \
    --data '{
        "name": "'$i'LogService",
        "type": "aliyun-log-service-datasource",
        "typeLogoUrl": "public/plugins/aliyun-log-service-datasource/img/sls_logo.jpg",
        "access": "proxy",
        "url": "http://'$region'.log.aliyuncs.com",
        "password": "",
        "user": "",
        "database": "",
        "basicAuth": false,
        "isDefault": false,
        "jsonData": {
            "logstore": "'$i'-metering-data",
            "project": "'$project'",
            "AccessKeyId": "'$ak'",
            "AccessKeySecret": "'$sk'"
        },
        "readOnly": false
    }'
done


echo '"'$ak'" "'$sk'"' > aksk.txt