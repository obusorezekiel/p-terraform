provider "aws" {
  region = "us-east-1"
}

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }

  # backend "s3" {
  #   bucket = "ezekiel-terraform-bucket"
  #   key    = "static-site/terraform.tfstate"
  #   region = "us-east-1"
  # }

  backend "s3" {
    bucket         = data.terraform_remote_state.setup.outputs.bucket_name
    key            = "terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = data.terraform_remote_state.setup.outputs.dynamodb_table_name
    encrypt        = true
  }
}

data "terraform_remote_state" "setup" {
  backend = "local"

  config = {
    path = "./terraform.tfstate"
  }
}

