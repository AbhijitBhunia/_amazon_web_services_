## <b><u><i>send-cloudwatch-logs-to-elasticsearch-via-lambda (AWS-Terraform PROJECT)</b></u></i>
***
<b>this is project to send AWS cloudwatch log group logs to elasticsearch using aws lambda, using loggroup subscription as a trigger for AWS lambda. Lambda written using python boto3.</b>

- <b>f0-kms.tf :</b>
  AWS KMS key to encrypt data of loggroup and secrets manager
  
- <b>f1-secrets_manager.tf :</b>
  AWS secrets manager to store Elasticsearch secrets (terraform to create and use CLI or console to store the secrets)
  
- <b>f2-lambda-functions.tf :</b>
  AWS lambda to collect Elasticsearch secrets from secrets manager and authenticate and post logs to elasticsearch also provide trigger permission to loggroup
  
- <b>f3-lambda-functions.tf :</b>
  A simple log creator can be replaced or modified for log creation
  
-<b>f4-cloudwatch_log_group.tf :</b>
  To create and manage Cloudwatch loggroup and also create subscription
***

## <b><u>Commands:</b></u>
***
- terraform init
- terraform fmt
- terraform validate
- terraform plan
- terraform apply -auto-approve
- terraform output > output.txt
- terraform destroy -auto-approve
***
