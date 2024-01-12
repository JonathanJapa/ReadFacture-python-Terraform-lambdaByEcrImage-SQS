module "converter" {
  source         = "../../infra/converter"
  environment    = var.environment

}

module "notifications"{
  source         = "../../infra/notifications"
  environment    = var.environment
}

module "buckets" {
  source         = "../../infra/buckets"
}
