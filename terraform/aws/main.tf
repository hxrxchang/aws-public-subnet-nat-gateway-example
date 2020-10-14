provider "aws" {
  region = "ap-northeast-1"
}

terraform {
  required_version = ">= 0.13.0"
  backend "s3" {
    bucket  = "aws-public-subnet-nat-gateway-example-tfstate"
    region  = "ap-northeast-1"
    key     = "terraform.tfstate"
    encrypt = true
  }
}

resource "aws_s3_bucket" "tfstate" {
  bucket = "aws-public-subnet-nat-gateway-example-tfstate"
  versioning {
    enabled = true
  }
}
