//*********************************************************************************
//Resources
//*********************************************************************************

data "archive_file" "lambda_archive_files" {
  type        = "zip"
  output_path = "${path.module}/files/index.zip"
  source {
    content  = <<EOF
def lambda_handler(event, context):
    print("I am just creating logs")
    print("vijay mourya is creator")
EOF
    filename = "index.py"
  }
}

resource "aws_lambda_function" "lambda_function_one" {
  description      = "normal print functions one"
  filename         = data.archive_file.lambda_archive_files.output_path
  function_name    = "one-just-a-log-creator"
  role             = aws_iam_role.state_change_lambda_role.arn
  handler          = "index.lambda_handler"
  source_code_hash = data.archive_file.lambda_archive_files.output_base64sha256
  runtime          = "python3.8"
}

//*********************************************************************************
//Roles
//*********************************************************************************

resource "aws_iam_role" "state_change_lambda_role" {
  name = "lambda-to-create-logs"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_policy" "log_lambda_role_policy" {
  name   = "LogCreatorLambdaRolePolicy"
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
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "lambda_role_policy_attachment" {
  policy_arn = aws_iam_policy.lambda_role_policy.arn
  role       = aws_iam_role.state_change_lambda_role.name
}
