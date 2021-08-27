//output "SNS_ID" {
//  description = "cloudwatch event rule ID"
//  value       = aws_sns_topic.sns_simple_notification_topic.id
//}
//
//output "SNS_ARN" {
//  description = "cloudwatch event rule ARN"
//  value       = aws_sns_topic.sns_simple_notification_topic.arn
//}
//
//output "SNS_name" {
//  description = "cloudwatch event rule name"
//  value       = aws_sns_topic.sns_simple_notification_topic.name
//}
//
//output "cloudwatch_ID" {
//  value = aws_cloudwatch_event_rule.cloudwatch_simple_event_rule.id
//}
//
//output "cloudwatch_ARN" {
//  value = aws_cloudwatch_event_rule.cloudwatch_simple_event_rule.arn
//}
//
//output "cloudwatch_payload" {
//  value = aws_cloudwatch_event_rule.cloudwatch_simple_event_rule.event_pattern
//}