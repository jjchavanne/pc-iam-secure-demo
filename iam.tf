resource "aws_iam_policy" "policy" {
  name        = "S3ReaderPolicy"
  path        = "/"
  description = "Allows to read objects from S3 buckets"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
        "Action": ["s3:ListBucket"],
        "Effect": "Allow",
        "Resource": ["arn:aws:s3:::my-company/home/${aws:username}/*"]
        }
    ]
})
}

resource "aws_iam_role" "test_role" {
  name = "test_role"
  assume_role_policy = jsonencode({
  "Version": "2012-10-17",
  "Statement": [
      {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "s3.amazonaws.com"
      },
      "Effect": "Allow"
      }
    ]
  })
}

data "aws_iam_policy_document" "example" {
  statement {
    sid = "1"
    effect = "Allow"
    actions = [
      "s3:Get*"
    ]

    resources = [
      "arn:aws:s3:::my-company"
    ]
  }
}
