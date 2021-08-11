resource "aws_cloudwatch_event_rule" "instance-state-change-rule" {
  name        = "ec2-state-change-rule"
  description = "Capture any ec2 instance state change"

  event_pattern = <<EOF
{
"source": [
  "aws.ec2"
],
"detail-type": [
  "EC2 Instance State-change Notification"
],
"detail": {
  "state": [
    "running",
    "stopped",
    "terminated"
  ]
}
}
EOF
  tags = {
    "Name"   = "state-change-alarm"
    "Source" = "Terraform"
    "User"   = "Vijayrmourya"
  }
}

resource "aws_cloudwatch_event_target" "sns" {
  rule      = aws_cloudwatch_event_rule.instance-state-change-rule.name
  target_id = "SendToSNS"
  arn       = aws_sns_topic.ec2-instance-state-updates.arn
}

//resource "aws_cloudwatch_event_target" "example" {
//  arn  = aws_lambda_function.example.arn
//  rule = aws_cloudwatch_event_rule.example.id
//
//  input_transformer {
//    input_paths = {
//      instance = "$.detail.instance",
//      status   = "$.detail.status",
//    }
//    input_template = "\"<instance> is in state <status>\""
//  }
//}
