#!/bin/bash



for i in oss pod slb rds mongodb redis apigateway
do
curl  --request DELETE "$1/api/datasources/name/${i}LogService"\
    --header "Authorization: Bearer $2" \
    --header 'Accept: application/json' \
    --header 'Content-Type: application/json' 
    
done




