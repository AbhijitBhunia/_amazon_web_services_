output "lambda_function_arn" {
  description = "lambda function ARN"
  value = aws_lambda_function.state_change_lambda_function.arn
}

output "lambda_function_id" {
  description = "lambda function ID"
  value = aws_lambda_function.state_change_lambda_function.id
}

output "lambda_function_name" {
  description = "lambda function name"
  value = aws_lambda_function.state_change_lambda_function.function_name
}

output "lambda_function_file_name" {
  description = "lambda function filename"
  value = aws_lambda_function.state_change_lambda_function.filename
}

output "sns_id" {
  description = "SNS function ID"
  value = aws_sns_topic.sns_simple_notification_topic.id
}

output "sns_arn" {
  description = "SNS function ARN"
  value = aws_sns_topic.sns_simple_notification_topic.arn
}

output "cloudwatch_event_rule" {
  value = aws_cloudwatch_event_rule.cloudwatch_simple_event_rule.event_pattern
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