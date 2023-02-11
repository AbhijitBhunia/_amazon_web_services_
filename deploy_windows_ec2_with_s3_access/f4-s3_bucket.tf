resource "aws_s3_bucket" "windows_bucket" {
  bucket = "bucket.for.windows.server"

  tags = merge({
    "project" = "WindowsServerProject1"
    },
    module.global_account_settings.tags
  )
}

resource "aws_s3_bucket_acl" "windows_buket_acl" {
  bucket = aws_s3_bucket.windows_bucket.id
  acl    = "private"
}

resource "aws_s3_bucket_policy" "allow_access_from_within_account" {
  bucket = aws_s3_bucket.windows_bucket.id
  policy = data.aws_iam_policy_document.allow_access_from_within.json
}

data "aws_iam_policy_document" "allow_access_from_within" {
  statement {
    principals {
      type        = "AWS"
      identifiers = ["087310217553"]
    }

    actions = [
      "s3:GetObject",
      "s3:ListBucket",
    ]

    resources = [
      aws_s3_bucket.windows_bucket.arn,
      "${aws_s3_bucket.windows_bucket.arn}/*",
    ]
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "example" {
  bucket = aws_s3_bucket.windows_bucket.bucket

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.s3_encryption.arn
      sse_algorithm     = "aws:kms"
      #      sse_algorithm     = "AES256"
    }
  }
}

resource "aws_s3_bucket_versioning" "windows_bucket_versioning" {
  bucket = aws_s3_bucket.windows_bucket.id
  versioning_configuration {
    status = "Enabled"
    #    status = "Disabled"
    #    status = "Suspended"
  }
}