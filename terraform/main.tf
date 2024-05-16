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


locals {
  name   = "production"
  region = var.region

  vpc_cidr = "10.0.0.0/16"
  azs      = slice(data.aws_availability_zones.available.names, 0, 3)

  container_name = "django-app"
  container_port = 8000

  tags = {
    Name      = local.name
    Terraform = "Yes"
  }
}