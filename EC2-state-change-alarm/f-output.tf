output "lambda-arn" {
  description = "lambda function ARN"
  value = aws_lambda_function.ec2_state_change_lambda_function.arn
}

output "lambda-name" {
  description = "lambda function name"
  value = aws_lambda_function.ec2_state_change_lambda_function.function_name
}

output "sns_name" {
  value = aws_sns_topic.ec2_state_change_sns.name
}


output "sns_arn" {
  value = aws_sns_topic.ec2_state_change_sns.arn
}

output "cloudwatch_rule_name" {
  value = aws_cloudwatch_event_rule.cloudwatch_simple_event_rule.name
}

output "cloudwatch_rule_arn" {
  value = aws_cloudwatch_event_rule.cloudwatch_simple_event_rule.arn
}

output "cloudwatch_rule_event_pattern" {
  value = aws_cloudwatch_event_rule.cloudwatch_simple_event_rule.event_pattern
}

output "cloudwatch_event_target" {
  value = aws_cloudwatch_event_target.target_lambda.arn
}

output "SNS_subscriber"{
  value = var.contact_person
}


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