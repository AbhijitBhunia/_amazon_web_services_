resource "aws_kms_key" "encryption-kms-key" {
  enable_key_rotation = false
  tags                = module.global_account_settings.tags
  policy              = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "*"
      },
      "Action": "kms:*",
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_kms_alias" "encryption-kms-key-alias" {
  target_key_id = aws_kms_key.encryption-kms-key.arn
  name          = "alias/encryption_kms_key_alias"
}