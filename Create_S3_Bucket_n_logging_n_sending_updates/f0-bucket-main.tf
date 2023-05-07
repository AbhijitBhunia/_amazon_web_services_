resource "aws_s3_bucket" "s3_Bucket0" {
  bucket        = var.bucket_name[0]
  force_destroy = true
  tags          = merge(
    module.global_account_settings.tags
  )
}

resource "aws_s3_bucket_acl" "s3_Bucket0_acl" {
  bucket = aws_s3_bucket.s3_Bucket0.id
  acl    = "private"
}

resource "aws_s3_bucket_intelligent_tiering_configuration" "s3_Bucket0_tiering" {
  bucket = aws_s3_bucket.s3_Bucket0.id
  name   = "EntireBucket"

  tiering {
    access_tier = "DEEP_ARCHIVE_ACCESS"
    days        = 180
  }
  tiering {
    access_tier = "ARCHIVE_ACCESS"
    days        = 125
  }
}

resource "aws_s3_bucket_logging" "example" {
  bucket        = aws_s3_bucket.s3_Bucket0.id
  target_bucket = aws_s3_bucket.log_bucket.id
  target_prefix = "log/"
}

resource "aws_s3_bucket_versioning" "versioning_example" {
  bucket = aws_s3_bucket.s3_Bucket0.id
  versioning_configuration {
    status = var.bucket_versioning
  }
}

resource "aws_s3_bucket_notification" "bucket_notification" {
  #  https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_notification
  bucket = aws_s3_bucket.s3_Bucket0.id

  topic {
    topic_arn = aws_sns_topic.bucket_update_topic.arn
    events    = ["s3:Object*:*"]
  }
}

resource "aws_s3_bucket_public_access_block" "example" {
  #  https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block
  bucket = aws_s3_bucket.s3_Bucket0.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_versioning" "versioning_example" {
  bucket = aws_s3_bucket.s3_Bucket0.id
  versioning_configuration {
    status = "Enabled"
  }
}

#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy