resource "aws_sns_topic" "ec2_state_change_sns" {
  name            = "state_change_sns_notify"
  tags            = module.global_account_settings.tags
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
  //  provisioner "local-exec" {
  //    command = "aws sns subscribe --topic-arn ${self.arn} --protocol email --notification-endpoint ${var.contact_person}"
  //  }
}

data "aws_iam_policy_document" "sns_topic_policy" {
  statement {
    effect  = "Allow"
    actions = ["SNS:Publish"]

    principals {
      type        = "Service"
      identifiers = ["events.amazonaws.com"]
    }
    resources = [aws_sns_topic.ec2_state_change_sns.arn]
  }
}

resource "aws_sns_topic_policy" "sns_topic_policy_attachment" {
  arn    = aws_sns_topic.ec2_state_change_sns.arn
  policy = data.aws_iam_policy_document.sns_topic_policy.json
}

resource "aws_sns_topic_subscription" "sns_subscription" {
  endpoint = var.contact_person
  protocol = "email"
  topic_arn = aws_sns_topic.ec2_state_change_sns.arn
}