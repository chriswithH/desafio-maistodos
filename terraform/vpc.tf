# data "aws_availability_zones" "available" {}

# module "default_aws_networking" {
#   source = "terraform-aws-modules/vpc/aws"
#   # version = "3.14.0"
#   version = "> 5"
#   name    = local.name
#   cidr    = local.vpc_cidr
#   azs     = local.azs

#   private_subnets  = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 8, k)]
#   public_subnets   = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 8, k + 4)]
#   database_subnets = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 8, k + 8)]

#   enable_nat_gateway = true
#   single_nat_gateway = true

#   tags = local.tags
# }
