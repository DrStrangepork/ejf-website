#!/usr/bin/env bash

export AWS_PROFILE=ejf

aws route53 list-hosted-zones-by-name --query "HostedZones[?Name=='extraordinarilyjustfine.com.']"
# Z051288935UXTG48K1Z3W
aws cloudformation validate-template --template-body file://template.yaml
aws cloudformation create-stack --stack-name ejf-website-s3 \
    --template-body file://template.yaml --parameters file://parameters.json
# aws cloudformation update-stack --stack-name ejf-website-s3 \
#     --template-body file://template.yaml --parameters file://parameters.json
# aws cloudformation deploy --stack-name ejf-website-s3 \
#     --template-file template.yaml --parameter-overrides $(cat parameters.properties)

# aws s3 cp --acl "public-read" index.html s3://ejf-website-s3-root
