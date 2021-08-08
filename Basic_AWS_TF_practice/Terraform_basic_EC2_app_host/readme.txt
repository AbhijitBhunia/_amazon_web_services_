EC2 instance created using terraform to host simple text content.

Note: after creating the instance edit the security group inbound traffinc rule to allow access to instance you me make it public for 5 minutes or so and after tesing terminate the instance.

Commands:
terraform init
terraform validate
terraform plan
terraform apply -auto-approve
terraform plan -destroy
terraform destroy -auto-approve