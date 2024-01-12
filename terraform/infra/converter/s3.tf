resource "aws_s3_bucket" "factures_trigger" {
  bucket = "factures-trigger"
}
resource "aws_s3_bucket" "factures_backup" {
  bucket = "factures-backup"
}
resource "aws_s3_bucket" "factures_error" {
  bucket = "factures-backup-error"
}



resource "aws_s3_bucket_notification" "factures_trigger_trigger" {
 bucket = aws_s3_bucket.factures_trigger.id 
 lambda_function {
    events = ["s3:ObjectCreated:*"]
 
    lambda_function_arn = aws_lambda_function.converter_lambda.arn
 }

}
resource "aws_ssm_parameter" "bucket_factures_triger" {
  name = "bucket-name-ssm"
  type = "String"
  value = "${aws_s3_bucket.factures_trigger.bucket}" 
  overwrite = true
}
resource "aws_ssm_parameter" "bucket_factures_backup" {
  name = "bucket-name-ssm"
  type = "String"
  value = "${aws_s3_bucket.factures_backup.bucket}" 
  overwrite = true
}

