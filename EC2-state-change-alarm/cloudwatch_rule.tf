resource "aws_cloudwatch_event_rule" "instance-state-change-rule" {
  name        = "ec2-state-change-rule"
  description = "Capture any ec2 instance state change"
  tags = module.global_account_settings.tags

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
}

resource "aws_cloudwatch_event_target" "sns" {
  rule      = aws_cloudwatch_event_rule.instance-state-change-rule.name
  target_id = "SendToSNS"
  arn       = aws_sns_topic.ec2-instance-state-updates.arn
}
