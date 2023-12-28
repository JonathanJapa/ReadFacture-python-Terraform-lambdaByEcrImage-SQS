module "logs" {
  source         = "../../infra/logs"
  environment     = var.environment
  write_capacity = 1
  read_capacity  = 1
}
