this is simple project to create EC2 instances in all AZs in a particular Region provided instance type supported in the
region, it detects if the instance is supported in the AZ or not and creates the instance if supported.

Supported Commands:
terraform init
terraform fmt
terraform validate
terraform plan
terraform apply -auto-approve
terraform output > filename.txt
terraform destroy -auto-approve