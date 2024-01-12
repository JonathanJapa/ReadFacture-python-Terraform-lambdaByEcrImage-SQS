data "archive_file" "converter" {
  type = "zip"
  source_dir = "${local.lambdas_path}"
  output_path = "files/${local.component_name}-artefact.zip"
}
data "aws_ecr_repository" "converter_lambda_img_docker" {
  name = aws_ecr_repository.converter_lambda_img_ecr.name
}

resource "aws_lambda_function" "converter_lambda" {
  function_name = local.component_name

  image_uri = local.img_ecr_uri
  package_type = "Image"

  role = aws_iam_role.converter_iam_role.arn
  timeout = 60

  # filename = data.archive_file.converter.output_path
  # source_code_hash = data.archive_file.converter.output_sha256


  environment {
    variables = {
      ENVIRONMENT = "${var.environment}"
      BUCKET_FACTURES = aws_s3_bucket.factures_trigger.bucket
      BUCKET_BACKUP = aws_s3_bucket.factures_backup.bucket
      AWS_ACCESS = var.aws_Access_key
      AWS_SECRET = var.aws_secret_key
      FACTURE_QUEUE_URL= var.facture_queue_url
      }
  }
}
 

