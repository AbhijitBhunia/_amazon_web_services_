## <b><u><i>EC2-state-change-alarm (AWS-Terraform PROJECT)</b></u></i>
***
<b> To create an cloudwatch alarm which sends a mail to the owner/subscriber (whichever email provided) when there's a state change for any of the instance in the given region.</b>

- <b>f0-lambda.tf :</b>
  AWS kambda to send mail to user whenever EC2 instance stace changes.
  
- <b>f1-sns_topic.tf :</b>
  AWS SNS topic to be used by the AWS lambda to send notification to user about state change
  
- <b>f2-cloudwatch_rule.tf :</b>
  Cloudwatch rule as lambda trigger whenever the EC2 instance changes state
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
