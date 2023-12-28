resource "aws_ssm_parameter" "dynamodb_logs_table" {
  name  = "${var.environment}-dynamodb-logs-table"
  type  = "String"
  value = "${aws_dynamodb_table.logs.name}"
}