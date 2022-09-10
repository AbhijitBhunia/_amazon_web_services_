resource "aws_sns_topic" "bucket_update_topic" {
  name = "s3-event-notification-topic"

  policy = <<POLICY
{
    "Version":"2012-10-17",
    "Statement":[{
        "Effect": "Allow",
        "Principal": {
            "Service": "s3.amazonaws.com"
        },
        "Action": "SNS:Publish",
        "Resource": "arn:aws:sns:*:*:s3-event-notification-topic",
        "Condition":{
            "ArnLike":{"aws:SourceArn":"${aws_s3_bucket.s3_Bucket0.arn}"}
        }
    }]
}
POLICY
}

resource "aws_sns_topic_subscription" "subscribe_bucket_updates" {
  endpoint  = var.contact_person
  protocol  = "email"
  topic_arn = aws_sns_topic.bucket_update_topic.arn
}