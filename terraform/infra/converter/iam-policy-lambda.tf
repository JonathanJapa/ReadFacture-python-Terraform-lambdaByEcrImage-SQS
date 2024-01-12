data "aws_iam_policy_document" "converter_iam_policy" {
  statement {
    effect    = "Allow"
    resources = ["arn:aws:logs:*:*"]
    actions   = ["logs:CreateLogGroup"]
  }

  statement {
    sid       = "AllowWritingLogs"
    effect    = "Allow"
    resources = ["arn:aws:logs:*:*:log-group:/aws/lambda/*:*"]
    actions   = ["logs:CreateLogStream", "logs:PutLogEvents"]
  }

  statement {
    effect    = "Allow"
    resources = ["arn:aws:s3:::${aws_s3_bucket.factures_trigger.id}/*"]
    actions   = ["s3:GetObject","s3:ListBucket", "s3:PutObject"]
  }

  statement {
    effect    = "Allow"
    resources = ["arn:aws:s3:::${aws_s3_bucket.factures_backup.id}/*"]
    actions   = ["s3:ListBucket", "s3:PutObject"]
  }
   statement {
    effect    = "Allow"
    resources = ["arn:aws:s3:::${aws_s3_bucket.factures_error.id}/*"]
    actions   = ["s3:ListBucket", "s3:PutObject"]
  }
 

  statement {
    effect    = "Allow"
    resources = [aws_ecr_repository.converter_lambda_img_ecr.arn]  
    actions   = ["ecr:GetDownloadUrlForLayer", "ecr:BatchCheckLayerAvailability", "ecr:BatchGetImage", "ecr:DescribeImages"]
  }
  
}

resource "aws_iam_policy" "converter_lambda" {
  name   = "${var.environment}-converter-policy"
  policy = data.aws_iam_policy_document.converter_iam_policy.json
}

resource "aws_lambda_permission" "allow_bucket" {
  statement_id  = "AllowExecutionFromS3Bucket"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.converter_lambda.function_name
  principal     = "s3.amazonaws.com"
  source_arn    = aws_s3_bucket.factures_trigger.arn
}

resource "aws_lambda_permission" "ecr_lambda_permission" {
  statement_id  = "AllowExecutionFromECR"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.converter_lambda.function_name
  principal     = "ecr.amazonaws.com"
}
resource "aws_iam_role_policy_attachment" "converter_iam_attachment" {
  policy_arn = aws_iam_policy.converter_lambda.arn
  role       = aws_iam_role.converter_iam_role.name
}
