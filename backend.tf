# resource block to create 2 ecr repos 
resource "aws_ecr_repository" "ecr_test" {
  for_each = toset(["tony","stark"])
  name = each.key
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

# configure the backend to store the terraform.tfstate file in remote location in our case the file will be stored in s3 
terraform {
  backend "s3" {
    bucket = "clari5-dev-bucket-1"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}
