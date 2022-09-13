resource "aws_s3_bucket" "s3_backend" {
  bucket        = var.bucket_name
  force_destroy = true
  tags = {
    resourcepurpose = "backend_state_bucket"
  }
}

resource "aws_s3_bucket_acl" "s3_Bucket0_acl" {
  bucket = aws_s3_bucket.s3_backend.id
  acl    = "private"
}

resource "aws_s3_bucket_versioning" "versioning__Bucket0" {
  bucket = aws_s3_bucket.s3_backend.id
  versioning_configuration {
    status = var.bucket_versioning
  }
}

resource "aws_s3_bucket_public_access_block" "Bucket0" {
  #  https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block
  bucket = aws_s3_bucket.s3_backend.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy
resource "aws_s3_bucket_policy" "s3_remote_backend_setup" {
  bucket = aws_s3_bucket.s3_backend.id
  policy = data.aws_iam_policy_document.s3_backend_policy.json
}

data "aws_iam_policy_document" "s3_backend_policy" {
  statement {
    actions = [
      "s3:ListBucket"
    ]
    resources = [
      aws_s3_bucket.s3_backend.arn,
    ]
    principals {
      identifiers = [
        data.aws_iam_user.main_user.arn
      ]
      type = "AWS"
    }
  }
  statement {
    actions = [
      "s3:GetObject", "s3:PutObject", "s3:DeleteObject"
    ]
    resources = [
      "${aws_s3_bucket.s3_backend.arn}/*",
    ]
    principals {
      identifiers = [
        data.aws_iam_user.main_user.arn
      ]
      type = "AWS"
    }
  }
}
