data "aws_iam_user" "main_user" {
  user_name = module.variables.global_profile
}