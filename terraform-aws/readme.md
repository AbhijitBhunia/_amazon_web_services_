# About repository

terraform projects for AWS

## Project list:

- basic-aws-account-setup-project
- create-ec2-in-every-AZ-in-region
- create-ec2-spot-instance-request
- create-windows-ec2-instance
- EC2-state-change-alarm
- send-cloudwatch-logs-to-elasticsearch-via-lambda

***
please refere project descreption below or project related readme file in each project folder.
***

## basic-aws-account-setup-project

- To setup VPC, Subnet and IGW etc as required by user

## create-ec2-in-every-AZ-in-region

- To created EC2 instance in each availability zone in the particular region

## create-ec2-spot-instance-request

- To create an spot ec2 instance using terraform

## create-windows-ec2-instance

- To create windows EC2 instance

## EC2-state-change-alarm

- To send an email to the subscriber(Account owner) whenever an EC2 instance is created and deleted (any state change)
  based on configuration.

## send-cloudwatch-logs-to-elasticsearch-via-lambda

- Use AWS lambda to send Cloudwatch loggroup logs to elacticsearch