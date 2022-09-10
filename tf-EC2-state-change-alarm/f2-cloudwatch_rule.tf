resource "aws_cloudwatch_event_rule" "cloudwatch_simple_event_rule" {
  name        = "ec2-state-change-rule"
  description = "Capture any ec2 instance state change"
  tags        = module.global_account_settings.tags

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
      "terminated",
      "stopped"
    ]
  }
}
EOF
}

resource "aws_cloudwatch_event_target" "target_lambda" {
  rule      = aws_cloudwatch_event_rule.cloudwatch_simple_event_rule.name
  target_id = "SendToLambda"
  arn       = aws_lambda_function.ec2_state_change_lambda_function.arn
}
