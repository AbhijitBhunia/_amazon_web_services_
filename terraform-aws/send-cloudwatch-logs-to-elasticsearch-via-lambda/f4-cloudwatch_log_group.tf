//*********************************************************************************
//Resources
//*********************************************************************************

resource "aws_cloudwatch_log_group" "loggroup_create_log_lambda_one" {
  name              = "/aws/lambda/${aws_lambda_function.lambda_function_one.function_name}"
  retention_in_days = 7
  tags              = module.global_account_settings.tags
  kms_key_id = aws_kms_key.encryption-kms-key.arn
}

resource "aws_cloudwatch_log_subscription_filter" "cloudwatch-sumologic-lambda-subscription" {
  name = "cloudwatch-sumologic-lambda-subscription"
  depends_on = [
    aws_cloudwatch_log_group.loggroup_create_log_lambda_one,
    aws_lambda_permission.lambda_cloudwatch_trigger_permission_one
  ]
  log_group_name  = aws_cloudwatch_log_group.loggroup_create_log_lambda_one.name
  filter_pattern  = ""
  destination_arn = aws_lambda_function.logging_lambda_function.arn
}
