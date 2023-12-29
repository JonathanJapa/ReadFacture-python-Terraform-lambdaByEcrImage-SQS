resource "aws_iam_policy" "convert_policy" {
  name        = "${var.environment}convert_policy"
  path        = "/"
  description = "My test policy"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "dynamodb:PutItem*",
        ]
        Effect   = "Allow"
        Resource = "${aws_dynamodb_table.logs.arn}"
      },
    ]
  })
}