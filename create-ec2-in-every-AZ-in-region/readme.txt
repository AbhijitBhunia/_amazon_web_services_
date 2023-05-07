this is simple project to create EC2 instances in all AZs in a particular Region provided instance type supported in the region, it detects if the instance is supported in the AZ or not and creates the instance if supported.

Commands:
terraform init
terraform fmt
terraform validate
terraform plan
terraform apply -auto-approve
terraform output > output.txt
terraform destroy -auto-approve
