resource "aws_dynamodb_table" "logs" {
  name     = "${var.environment}-logs"
  hash_key = "id"
  attribute {
    name = "id"
    type = "S"
  }
  write_capacity = var.write_capacity
  read_capacity  = var.read_capacity
}



