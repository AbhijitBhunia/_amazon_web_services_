data "archive_file" "state_change_lambda_archive" {
  type = "zip"
  output_path = "${path.module}/files/index.zip"
  source {
    content = <<EOF
import boto3
import json
def lambda_handler(event, context):
    instance_id = event['detail']['instance-id']
    state = event['detail']["state"]
    time = event['time']
    region = event["region"]
    resources = event["resources"][0]

    #ec2 = boto3.client('ec2',"${var.aws_region}")
    #myinstance = ec2.describe_instances(InstanceIds=[instance_id])
    #typedetails="Instance type: "myinstance[instance-type]+"\nInstance IP address: "+myinstance[ip-address]

    MY_SNS_TOPIC_ARN = "${aws_sns_topic.sns_simple_notification_topic.arn}"
    sns_client = boto3.client('sns',"${var.aws_region}")
    sns_client.publish(
        TopicArn = MY_SNS_TOPIC_ARN,
        Subject = 'Instance Change State: '+instance_id,
        Message = 'Instance: '+instance_id+' has changed state\n'+'State: '+state+' at '+time+'\n'+'Region: '+region+'\n'+'Resource ARN: '+resources
    )
EOF
    filename = "index.py"
  }
}

resource "aws_iam_role" "state_change_lambda_role" {
  name = "${var.variant_name}-lambda_sns_for_ec2_state_change"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_lambda_function" "state_change_lambda_function" {
  description      = "To customize the email details for EC2 instance state changes"
  filename         = data.archive_file.state_change_lambda_archive.output_path
  function_name    = "EC2_state_change_lambda"
  role             = aws_iam_role.state_change_lambda_role.arn
  handler          = "index.lambda_handler"
  source_code_hash = data.archive_file.state_change_lambda_archive.output_base64sha256
  runtime          = "python3.8"
}

resource "aws_lambda_alias" "lambda_state_change_alias" {
  name             = "${var.variant_name}-my_alias"
  description      = "lambda alias"
  function_name    = aws_lambda_function.state_change_lambda_function.arn
  function_version = "$LATEST"
}

resource "aws_lambda_permission" "lambda_cloudwatch_trigger_permission" {
  statement_id  = "AllowExecutionFromCloudwatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.state_change_lambda_function.arn
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.cloudwatch_simple_event_rule.arn
}

resource "aws_iam_policy" "lambda_role_policy" {
  name   = "${var.variant_name}-LambdaRolePolicy"
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
  role       = aws_iam_role.state_change_lambda_role.name
}
