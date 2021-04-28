#
# Terraform Config Block
#
terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "myorg"

    workspaces {
      name = "aws_us-east-1_test-vpc_public-box"
    }
  }

  required_version = "0.14.10"

  required_providers {
    aws = { version = "~> 3.0" }
  }
}

provider "aws" {
  region = "us-east-1"
}
