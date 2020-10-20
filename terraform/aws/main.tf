provider "aws" {
  region = "ap-northeast-1"
}

terraform {
  required_version = ">= 0.13.0"
  backend "s3" {
  }
}

variable key_name {
  type = string
}

variable public_key_path {
  type = string
}

variable backend_s3_bucket {
  type = string
}
