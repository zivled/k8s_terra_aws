terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# providor
provider "aws" {
  region     = var.aws_region
  # access keys by env vars
  # export AWS_ACCESS_KEY_ID=""
  # export AWS_SECRET_ACCESS_KEY=""
}

