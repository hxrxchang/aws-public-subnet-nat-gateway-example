provider "aws" {
  region = "ap-northeast-1"
}

terraform {
  required_version = ">= 0.13.0"
  backend "s3" {
    bucket  = "hxrxchang-terraform-state"
    region  = "ap-northeast-1"
    key     = "aws-public-subnet-nat-gateway-example.tfstate"
    encrypt = true
  }
}

variable key_name {
  type = string
}

variable public_key_path {
  type = string
}
