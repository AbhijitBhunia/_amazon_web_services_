## <b><u><i>create-ec2-in-every-AZ-in-region (AWS-Terraform PROJECT)</b></u></i>
***
<b> To create EC2 instances in all AZs in a particular Region provided instance type supported in the region, it detects if the instance is supported in the AZ or not and creates the instance if supported.</b>

- <b>app1-install.sh :</b>
  user data file for the EC2 instance.
  
- <b>f0-get-instancetype-supported-per-az-in-a-region.tf :</b>
  get the list of AZs that support the required instance type as declared

- <b>f1-ami-datasource.tf :</b>
  To create the AMI datasource using terraform
  
- <b>f2-ec2-security-groups.tf :</b>
  To create security group for the ec2 instances
  
- <b>f3-ec2-instance.tf :</b>
  the EC2 instance resource definition.
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
