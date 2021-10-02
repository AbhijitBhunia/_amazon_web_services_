## <b><u><i>basic-aws-account-setup-project (AWS-Terraform PROJECT)</b></u></i>
***
<b> this project is to setup the AWS account for personal setting to craete personal VPC, subnets and all network setting</b>

- <b>f1-AWS-VPC-setup :</b>
  To setup the VPC with personal CIDR blocks as per requirements.
  
- <b>f2-AWS-subnet-setup :</b>
  To setup the Subnet with personal CIDR blocks and divide the network into private and public block
  
- <b>f3-internet-gateway :</b>
  To setup internaet gateway to connect the VPC and subnet to internet i.e. 0.0.0.0/0
  
- <b>f4-AWS-route-table :</b>
  To create Route table for VPC
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
