import boto3

region = "ap-south-1"
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
    instance_name='No name tagged'

    TAG = ''
    for i in tags:
        k=list(i.keys())
        for j in k:
            if str(i[j])=='name':
                name = 'Tagged '+ i[j] +" : "+i['Value']
            TAG = TAG + i[j] + ' '
        TAG = TAG+'\n'

    MY_SNS_TOPIC_ARN = "arn:aws:sns:ap-south-1:064558089886:state_change_sns_notify"
    sns_client = boto3.client('sns', region)
    msg = 'Instance ID:   ' + instance_id + '\n' + 'State:   ' + state + '\n' + 'Region:   ' + region + '\n' + 'Instance AMI ID:   ' + AMI_ID + '\n' + 'Instance type:   ' + Instance_type + '\n' + 'Instance ARN:   ' + resources_ARN + '\n' + 'Tag details as mentioned below: \n' + TAG

    if (state == "running"):
        sub = 'EC2 Instance State changed to Running (' + name + ')'
        sns_client.publish(
            TopicArn = MY_SNS_TOPIC_ARN,
            Subject = sub,
            Message = msg
        )
    elif (state == "stopped"):
        sub = 'EC2 Instance is stopped (' + name + ')'
        sns_client.publish(
            TopicArn = MY_SNS_TOPIC_ARN,
            Subject = sub,
            Message = msg
        )
    elif (state == "terminated"):
        sub = 'EC2 Instance is Terminated (' + name + ')'
        sns_client.publish(
            TopicArn = MY_SNS_TOPIC_ARN,
            Subject = sub,
            Message = msg
        )
