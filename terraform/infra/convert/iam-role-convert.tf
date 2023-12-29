resource "aws_iam_role" "convert_iam_role" {
  name = "${var.environment}-convert_iam_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      },
    ]
  })
}
resource "aws_ssm_parameter" "convert_iam_role" {
  name = "${var.environment}-convert_iam_role"
  type = "String"
  value = "${aws_iam_role.convert_iam_role.arn}"
}