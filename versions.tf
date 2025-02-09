terraform {
  required_version = "~> 1.0"

  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~>5.0"
    }
  }

    backend "s3" {
      bucket = "abhishek-infra-github"
      key    = "infra/github/terraform.tfstate"
      region = "ap-south-1" # terraform block don't have access to variables
      encrypt = true
    }
}

provider "aws" {
  region = var.aws_region
}