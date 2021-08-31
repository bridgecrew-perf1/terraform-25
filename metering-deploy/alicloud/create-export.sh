aliyun configure set --profile akProfile --mode AK \
  --region  ${region} \
  --access-key-id ${ak} \
  --access-key-secret ${sk}

aliyun cms PutExporterOutput --DestName 'oss-metering-report-'${env}'' --ConfigJson '{ "endpoint": "http://'${region}'-share.log.aliyuncs.com", "project": "'${project}'", "logstore": "oss-metering-data","ak": "'${ak}'", "userId": "'${userid}'", "as": "'${sk}'"}' --Desc 'oss-metering-report-'${env}'' --DestType sls --region ${region}

sleep 60


