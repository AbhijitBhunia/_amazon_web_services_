resource "aws_s3_bucket" "s3_Bucket_test" {
  bucket        = "testbucketvjmourya-hclcloud"
  force_destroy = true
}