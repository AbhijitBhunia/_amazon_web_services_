resource "aws_secretsmanager_secret" "elasticsearch-credentials" {
  depends_on = [aws_kms_key.encryption-kms-key]
  name = "elasticsearch_credentials"
  recovery_window_in_days = 30
  kms_key_id = aws_kms_key.encryption-kms-key.arn
  tags            = module.global_account_settings.tags
}

resource "aws_secretsmanager_secret_version" "sversion" {
  secret_id = aws_secretsmanager_secret.elasticsearch-credentials.id
  secret_string = <<EOF
{
  "Username":"YourID",
  "Password":"YourPassword"
}
EOF
}

resource "aws_secretsmanager_secret_policy" "example" {
  secret_arn = aws_secretsmanager_secret.elasticsearch-credentials.arn

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "*"
      },
      "Action": "secretsmanager:*",
      "Resource": "*"
    }
  ]
}
POLICY
}