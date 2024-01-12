locals {
  component_name = "converter-lambda"
  lambdas_path = "${path.module}/../../../converter"
  docker_path = "${path.module}/../../../converter/dockerfile"
  img_ecr_uri = "734426407668.dkr.ecr.us-east-1.amazonaws.com/converter_lambda_img_docker:0.0.2"
  img_name = "converter_lambda_img_ecr"
  img_version = "latest"
  aws_region = "us-east-1"
}
