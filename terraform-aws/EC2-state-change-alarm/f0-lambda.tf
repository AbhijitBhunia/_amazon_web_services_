data "archive_file" "lambda_archive" {
  type        = "zip"
  output_path = "${path.module}/files/index.zip"
  source {
    content  = <<EOF
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
    instance_name='No name tagged'
    name = ""

    TAG = ''
    for i in tags:
        k=list(i.keys())
        for j in k:
            if str(i[j])=='name' or str(i[j])=='Name' or str(i[j])=='NAME':
                name = 'Tagged '+ i[j] +" : "+i['Value']
            TAG = TAG + i[j] + ' '
        TAG = TAG+'\n'

    MY_SNS_TOPIC_ARN = "${aws_sns_topic.ec2_state_change_sns.arn}"
    sns_client = boto3.client('sns', region)
    msg = 'Instance ID:   ' + instance_id + '\n' + 'State:   ' + state + '\n' + 'Region:   ' + region + '\n' + 'Instance AMI ID:   ' + AMI_ID + '\n' + 'Instance type:   ' + Instance_type + '\n' + 'Instance ARN:   ' + resources_ARN + '\n' + 'Tag details as mentioned below: \n' + TAG

    if (state == "running"):
        sub = 'EC2 Instance (' + instance_id + ') State changed to Running (' + name + ')'
        sns_client.publish(
            TopicArn = MY_SNS_TOPIC_ARN,
            Subject = sub,
            Message = msg
        )
    elif (state == "stopped"):
        sub = 'EC2 Instance (' + instance_id + ') State changed to Stopped (' + name + ')'
        sns_client.publish(
            TopicArn = MY_SNS_TOPIC_ARN,
            Subject = sub,
            Message = msg
        )
    elif (state == "terminated"):
        sub = 'EC2 Instance (' + instance_id + ') State changed to Terminated (' + name + ')'
        sns_client.publish(
            TopicArn = MY_SNS_TOPIC_ARN,
            Subject = sub,
            Message = msg
        )

EOF
    filename = "index.py"
  }
}

resource "aws_iam_role" "lambda_role" {
  name               = "lambda_sns_for_ec2_state_change"
  tags               = module.global_account_settings.tags
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_lambda_function" "ec2_state_change_lambda_function" {
  description      = "lambda to customize the email details for EC2 instance state changes"
  filename         = data.archive_file.lambda_archive.output_path
  function_name    = "ec2_state_change_lambda"
  role             = aws_iam_role.lambda_role.arn
  handler          = "index.lambda_handler"
  source_code_hash = data.archive_file.lambda_archive.output_base64sha256
  runtime          = "python3.8"
  tags             = module.global_account_settings.tags
}

resource "aws_lambda_permission" "lambda_cloudwatch_trigger_permission" {
  statement_id  = "AllowExecutionFromCloudwatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.ec2_state_change_lambda_function.arn
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.cloudwatch_simple_event_rule.arn
}

resource "aws_iam_policy" "lambda_role_policy" {
  name   = "state_change_Lambda_Role_Policy"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Effect": "Allow",
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": "ec2:Describe*",
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": "elasticloadbalancing:Describe*",
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": [
          "cloudwatch:ListMetrics",
          "cloudwatch:GetMetricStatistics",
          "cloudwatch:Describe*"
      ],
      "Resource": "*"
    },
    {
      "Action" : [
          "sns:Publish",
          "sns:Subscribe"
      ],
      "Effect" : "Allow",
      "Resource" : "*"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "lambda_role_policy_attachment" {
  policy_arn = aws_iam_policy.lambda_role_policy.arn
  role       = aws_iam_role.lambda_role.name
}

