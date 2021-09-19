# lambda to send notification over mail extract EC2 details to be used with Terraform
import boto3

region = "${var.aws_region}"
def lambda_handler(event, context):
    instance_id = event['detail']['instance-id']
    state = event['detail']["state"]
    region = event["region"]
    resources_ARN = event["resources"][0]

    ec2 = boto3.client('ec2', region)
    myinstance = ec2.describe_instances(InstanceIds=[instance_id])

    AMI_ID = myinstance['Reservations'][0]['Instances'][0]['ImageId']
    Instance_type = myinstance['Reservations'][0]['Instances'][0]['InstanceType']
    tags = myinstance['Reservations'][0]['Instances'][0]['Tags']
    TAG = ''
    for i in tags:
        TAG=TAG+str(i)+'\n'
    MY_SNS_TOPIC_ARN = "${aws_sns_topic.ec2_state_change_sns.arn}"
    sns_client = boto3.client('sns', region)
    msg = 'Instance ID:   ' + instance_id + '\n' + 'State:   ' + state + '\n' + 'Region:   ' + region + '\n' + 'Instance AMI ID:   ' + AMI_ID + '\n' + 'Instance type:   ' + Instance_type + '\n' + 'Instance ARN:   ' + resources_ARN + '\n' + 'Tag details: \n' + TAG

    if (state == "running"):
        sub = instance_id + ' : EC2 Instance State changed to Running'
        sns_client.publish(
            TopicArn = MY_SNS_TOPIC_ARN,
            Subject = sub,
            Message = msg
        )
    elif (state == "stopped"):
        sub = instance_id + ' : EC2 Instance is stopped'
        sns_client.publish(
            TopicArn = MY_SNS_TOPIC_ARN,
            Subject = sub,
            Message = msg
        )
    elif (state == "terminated"):
        sub = instance_id + ' : EC2 Instance is Terminated'
        sns_client.publish(
            TopicArn = MY_SNS_TOPIC_ARN,
            Subject = sub,
            Message = msg
        )
