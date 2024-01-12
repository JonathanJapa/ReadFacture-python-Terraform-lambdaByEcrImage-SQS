data "aws_caller_identity" "current" {}
output "arn" {
  value = data.aws_caller_identity.current.arn
  
}
output "account_id" {
  value = data.aws_caller_identity.current.account_id
}


module "converter"{
  source = "../../infra/converter"
  environment = "${var.environment}"
  aws_Access_key = "${var.aws_access_key}"
  aws_secret_key = "${var.aws_secret_key}"
  arn = data.aws_caller_identity.current.arn
  account_id= data.aws_caller_identity.current.account_id
  facture_queue_url = "${var.facture_queue_url}"
}


module "notifications" {
  source = "../../infra/notifications"
  environment = "${var.environment}"
}

module "write" {
  source = "../../infra/write"
  environment = "${var.environment}"
}


