resource "aws_ecr_repository" "converter_lambda_img_ecr" {	
    name = "converter_lambda_img_docker"
      image_scanning_configuration {
    scan_on_push = true
  }
  
  
  image_tag_mutability = "MUTABLE"  

  lifecycle {
    prevent_destroy = false
  }
}
resource "aws_ecr_repository_policy" "converter_lambda_img_ecr_policy" {
  repository = aws_ecr_repository.converter_lambda_img_ecr.name

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = "*",
        Action = [
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchCheckLayerAvailability",
          "ecr:BatchGetImage",
          "ecr:DescribeImages",
        ],
      },
    ],
  })
}
# resource "null_resource" "docker_packaging" {
	
# 	  provisioner "local-exec" {
# 	    command = <<EOF
# 	   aws ecr get-login-password --region ${local.aws_region} | docker login --username AWS --password-stdin ${var.account_id}.dkr.ecr.${local.aws_region}.amazonaws.com
	   
# 	    docker build -t "${aws_ecr_repository.converter_lambda_img_ecr.repository_url}:${local.img_version}" -f ${local.docker_path} .


#       docker tag ${local.img_name}:${local.img_version} ${var.account_id}.dkr.ecr.${local.aws_region}.amazonaws.com/${aws_ecr_repository.converter_lambda_img_ecr.name}:${local.img_version}
      
#       docker push ${var.account_id}.dkr.ecr.${local.aws_region}.amazonaws.com/${aws_ecr_repository.converter_lambda_img_ecr.name}:${local.img_version}
# 	    EOF
# 	  }
    

	
	

# 	  depends_on = [
# 	    aws_ecr_repository.converter_lambda_img_ecr
# 	  ]







