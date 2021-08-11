resource "aws_sns_topic" "ec2-instance-state-updates" {
  name            = "ec2-instance-state-change"
  delivery_policy = <<EOF
{
  "http": {
    "defaultHealthyRetryPolicy": {
      "minDelayTarget": 20,
      "maxDelayTarget": 20,
      "numRetries": 3,
      "numMaxDelayRetries": 0,
      "numNoDelayRetries": 0,
      "numMinDelayRetries": 0,
      "backoffFunction": "linear"
    },
    "disableSubscriptionOverrides": false
  }
}
EOF
  tags = {
    "Name"   = "state-change-alarm"
    "Source" = "Terraform"
    "User"   = "Vijayrmourya"
  }
  provisioner "local-exec" {
    command = "aws sns subscribe --topic-arn ${self.arn} --protocol email --notification-endpoint ${var.contact_person}"
  }

}

resource "aws_sns_topic_policy" "default" {
  arn    = aws_sns_topic.ec2-instance-state-updates.arn
  policy = data.aws_iam_policy_document.sns_topic_policy.json
}