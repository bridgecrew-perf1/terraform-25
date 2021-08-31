aliyun cms PutExporterRule --RuleName 'MeteringStorageUtilization-rule' --Namespace acs_oss_dashboard --MetricName MeteringStorageUtilization --TargetWindows 3600 --DstNames.1 'oss-metering-report-'${env}'' --Describe 'MeteringStorageUtilization-rule' --region ${region}
aliyun cms PutExporterRule --RuleName 'MeteringGetRequest-rule' --Namespace acs_oss_dashboard --MetricName MeteringGetRequest --TargetWindows 3600 --DstNames.1 'oss-metering-report-'${env}'' --Describe 'MeteringGetRequest-rule' --region ${region}
aliyun cms PutExporterRule --RuleName 'MeteringPutRequest-rule' --Namespace acs_oss_dashboard --MetricName MeteringPutRequest --TargetWindows 3600 --DstNames.1 'oss-metering-report-'${env}'' --Describe 'MeteringPutRequest-rule' --region ${region}
aliyun cms PutExporterRule --RuleName 'InternetSend-rule' --Namespace acs_oss_dashboard --MetricName InternetSend --TargetWindows 60 --DstNames.1 'oss-metering-report-'${env}'' --Describe 'InternetSend-rule' --region ${region}

