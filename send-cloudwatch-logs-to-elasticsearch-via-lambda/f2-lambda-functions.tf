resource "aws_iam_role" "lambda_role" {
  name               = "lambda_for_sending_logs_to_ES"
  tags               = module.global_account_settings.tags
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": [
          "lambda.amazonaws.com",
          "secretsmanager.amazonaws.com",
          "mrk.kms.amazonaws.com"
        ]
      },
      "Effect": "Allow"
    }
  ]
}
EOF
}

resource "aws_iam_policy" "lambda_role_policy" {
  name   = "loggerLambdaRolePolicy"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents",
        "sns:Publish",
        "sns:Subscribe"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "logger_lambda_role_policy_attachment" {
  policy_arn = aws_iam_policy.lambda_role_policy.arn
  role       = aws_iam_role.lambda_role.name
}


data "archive_file" "logging_lambda_archive" {
  type        = "zip"
  output_path = "${path.module}/files/logger.zip"
  source {
    content  = <<EOF
import os
import json
import boto3
import gzip
import base64
import base64
import requests

region_name = '${var.aws_region}'
secret_name = '${aws_secretsmanager_secret.elasticsearch-credentials.name}'

log_group = boto3.client('logs')

host = os.environ['host_name']
headers = {'Content-type': 'application/json','Accept': 'text/plain'}

def lambda_handler(event, context):

    cw_data = event['awslogs']['data']
    compressed_data = base64.b64decode(cw_data)
    uncompressed_data = gzip.decompress(compressed_data)
    data = json.loads(uncompressed_data)
    log_events = data['logEvents']

    session = boto3.session.Session()
    client = session.client( service_name='secretsmanager', region_name=region_name)
    get_secrets = client.get_secrets_value( SecretId = secret_name)
    cred_str = get_secrets['SecretString']
    cred_json = json.loads(cred_str)
    ID = cred_json['Username']
    password = cred_json['Password']
    log_json = json.dumps(data)

    try:
        response = requests.post(host, auth=(ID, password), data=log_json, headers=headers, timeout=30)
        print("status code: \n", response.status_code)
        print("elapsed time: \n", response.elapsed)
        print("text response: \n", response.text)
        print("request type: \n", response.request)
        print("reason of response: \n", response.reason)
    except requests.Timeout as response:
        print("status code: \n", response.status_code)
        print("elapsed time: \n", response.elapsed)
        print("text response: \n", response.text)
        print("request type: \n", response.request)
        print("reason of response: \n", response.reason)
EOF
    filename = "lambda_ES.py"
  }
}

resource "aws_lambda_function" "logging_lambda_function" {
  description      = "To customize the email details for EC2 instance state changes"
  filename         = data.archive_file.logging_lambda_archive.output_path
  function_name    = "lambda-to-share-logs-to-elasticsearch"
  role             = aws_iam_role.lambda_role.arn
  handler          = "lambda_ES.lambda_handler"
  source_code_hash = data.archive_file.logging_lambda_archive.output_base64sha256
  runtime          = "python3.8"
  environment {
    variables = {
      host_name = "yourelasticsearchhostname.com"
    }
  }
}

resource "aws_lambda_permission" "lambda_cloudwatch_trigger_permission_one" {
  statement_id  = "AllowExecutionFromCloudwatchone"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.logging_lambda_function.function_name
  principal     = "logs.${var.aws_region}.amazonaws.com"
  source_arn    = "${aws_cloudwatch_log_group.loggroup_create_log_lambda_one.arn}:*"
}