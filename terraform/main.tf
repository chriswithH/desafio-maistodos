terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.18.0"
    }
  }

  backend "s3" {
    bucket         = "maistodos-tfstate"
    key            = "state/terraform.tfstate"
    region         = "us-east-2"
    encrypt        = true
    dynamodb_table = "maistodos_tf_lockid"
  }
}

provider "aws" {
  region = var.region
}

