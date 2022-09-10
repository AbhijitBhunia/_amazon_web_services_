## <b><u><i>create-windows-ec2-instance (AWS-Terraform PROJECT)</b></u></i>

***
<b> To create WINDOWS EC2 instances in a given AWS AZ. After creating the instance creates and saves the Private key and Admin password into your local directory</b>

- <b>f0-instance.tf :</b>
  Instance configurations
- <b>f1-ec2-key-pair.tf :</b>
  EC-2 instance access key pair. the key pair will be exported into ["${path.module}/privet-key/create_ec2_in_every_AZ_in_region_key.pem"] and saves Admin Password into ["${path.module}/private-key/windows-admin-password.txt"]
- <b>f2-ec2-security-groups.tf :</b>
  To create security group for the ec2 instances
- <b>f-User-data.sh :</b>
  user data file for the EC2 instance.
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
