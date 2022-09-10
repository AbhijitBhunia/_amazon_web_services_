# About Project

To create an AWS EC2 instance using AWS CLI

---

# Step 1: Obtain the AMI ID

- Set the Region\
  COMMAND: \
  $ AZ=\`us-west-2`\
  $ export AWS_DEFAULT_REGION=${AZ}

- Obtain latest Linux AMI \
  COMMAND: \
  $ AMI=$(aws ssm get-parameters --names /aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2 --query '
  Parameters[0].[Value]' --output text)\
  $ echo $AMI

# Step 2: Obtain the subnet

COMMAND: \
$ SUBNET=$(aws ec2 describe-subnets --filters 'Name=tag:Name,Values=MyPublicSubnet' --query Subnets[].SubnetId --output
text)
$ echo $SUBNET

# Step3: Obtain the security group

COMMAND: \
$ SG=$(aws ec2 describe-security-groups --filters Name=tag:Name,Values=MySecurityGroup --query SecurityGroups[].GroupId
--output text)
$ echo $SG

# Step4: Create User Data

COMMAND: \
$ echo "#!/bin/bash -ex \
sudo yum update -y \
sudo yum install -y httpd php \
sudo service httpd start \
sudo systemctl enable httpd.service \
cd /var/www/html \
wget https://us-west-2-tcprod.s3.amazonaws.com/courses/ILT-TF-200-ARCHIT/v7.1.9/lab-1-EC2/scripts/instanceAdata.zip \
unzip instanceAdata.zip" >> ./UserData.txt

# step5: Create the instance

COMMAND: \
$ INSTANCE=$(\
aws ec2 run-instances \
--image-id $AMI \
--subnet-id $SUBNET \
--security-group-ids $SG \
--user-data file://./UserData.txt \
--instance-type t3.micro \
--tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=InstanceB}]' \
--query 'Instances[*].InstanceId' \
--output text \
)\
$ echo $INSTANCE

# Step5: wait for instance to be ready

$ aws ec2 describe-instances --instance-ids $INSTANCE\
$ aws ec2 describe-instances --instance-ids $INSTANCE --query 'Reservations[].Instances[].State.Name' --output text

# step6: test the instance

$ aws ec2 describe-instances --instance-ids $INSTANCE --query Reservations[].Instances[].PublicDnsName --output text
