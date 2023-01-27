resource "aws_iam_policy" "HighPrivPolicy" {
  name        = "HighPrivPolicy"
  path        = "/"
  description = "Allows Admin Privileges"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
	 "Version": "2012-10-17",
	 "Statement": [
	   {
     "Action": "*",
		 "Effect": "Allow",
		 "Resource": "*"
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
        "AWS": "*"
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
      "iam:AttachUserPolicy"
    ]

    resources = [
      "*"
    ]
  }
}
