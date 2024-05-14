module "security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 5.0"

  name        = "db_sg"
  description = "SG for Postgres database"
  vpc_id      = module.default_aws_networking.vpc_id


  ingress_with_cidr_blocks = [
    {
      from_port   = 5432
      to_port     = 5432
      protocol    = "tcp"
      description = "PostgreSQL access from within VPC"
      cidr_blocks = module.default_aws_networking.vpc_cidr_block
    },
  ]

  tags = {
    Name      = "db_sg"
    Terraform = "Yes"
  }
}


module "rds_instance" {
  source  = "terraform-aws-modules/rds/aws"
  version = "6.6.0"

  identifier           = local.name
  engine               = "postgres"
  engine_version       = "14"
  family               = "postgres14"
  major_engine_version = "14"
  instance_class       = "db.t3.micro"
  allocated_storage    = 20

  db_name             = local.name
  username            = "uname"
  port                = 5432
  skip_final_snapshot = true

  multi_az               = false
  db_subnet_group_name   = module.default_aws_networking.database_subnet_group
  vpc_security_group_ids = [module.security_group.security_group_id]

  maintenance_window      = "Mon:00:00-Mon:03:00"
  backup_window           = "03:00-06:00"
  backup_retention_period = 0

  tags = local.tags
}