provider "aws" {}

terraform {
  required_version = "~> 1.11"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.95"
    }
  }

  backend "s3" {
    bucket  = "terraform-tfstate-plan8"
    key     = "global.tfstate"
    region  = "ap-northeast-1"
    encrypt = true
  }
}
