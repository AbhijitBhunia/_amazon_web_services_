data "aws_iam_policy_document" "instance_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "instance_role" {
  name               = "instance_role"
  path               = "/project/"
  assume_role_policy = data.aws_iam_policy_document.instance_assume_role_policy.json
}

resource "aws_iam_instance_profile" "windows_server_profile" {
  name = "windows_server_profile"
  role = aws_iam_role.instance_role.name
}

resource "aws_iam_role_policy_attachment" "s3_read_only" {
  role       = aws_iam_role.instance_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
}

#resource "aws_iam_role_policy" "test_policy" {
#  name = "test_policy"
#  role = aws_iam_role.instance_role.id
#
#  # Terraform's "jsonencode" function converts a
#  # Terraform expression result to valid JSON syntax.
#  policy = jsonencode(
#    {
#      "Version" : "2012-10-17",
#      "Statement" : [
#        {
#          "Effect" : "Allow",
#          "Action" : ["s3:ListBucket"],
#          "Resource" : [
#            aws_s3_bucket.windows_bucket.arn
#          ]
#        },
#        {
#          "Effect" : "Allow",
#          "Action" : [
#            "s3:PutObject",
#            "s3:GetObject",
#            "s3:DeleteObject"
#          ],
#          "Resource" : [
#            "${aws_s3_bucket.windows_bucket.arn}/*"
#          ]
#        }
#      ]
#    }
#  )
#}
