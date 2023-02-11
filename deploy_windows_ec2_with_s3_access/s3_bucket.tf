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