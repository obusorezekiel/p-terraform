terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }

  backend "s3" {
    bucket = "ezekiel-terraform-bucket"
    key    = "static-site/terraform.tfstate"
    region = "us-east-1"
  }
}


provider "aws" {
  region = "us-east-1"
}