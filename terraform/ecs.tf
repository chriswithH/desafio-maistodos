

# ################################################################################
# # Cluster
# ################################################################################

# module "ecs_cluster" {
#   source = "./modules/cluster"

#   cluster_name = local.name

#   # Capacity provider
#   fargate_capacity_providers = {
#     FARGATE = {
#       default_capacity_provider_strategy = {
#         weight = 50
#         base   = 20
#       }
#     }
#     FARGATE_SPOT = {
#       default_capacity_provider_strategy = {
#         weight = 50
#       }
#     }
#   }

#   tags = local.tags
# }


# module "ecs_task_definition" {
#   source = "./modules/service"

#   name        = local.name
#   cluster_arn = module.ecs_cluster.arn

#   cpu    = 1024
#   memory = 4096

#   # Enables ECS Exec
#   enable_execute_command = true

#   # Container definition(s)
#   container_definitions = {

#     # django-app = {
#     #   cpu       = 512
#     #   memory    = 1024
#     #   essential = true
#     #   image     = # image url
#     #   memory_reservation = 50
#     #   user               = "0"
#     # }

#     (local.container_name) = {
#       cpu       = 512
#       memory    = 1024
#       essential = true
#       image     = "590183821071.dkr.ecr.us-east-2.amazonaws.com/django-app:latest"
#       port_mappings = [
#         {
#           name          = local.container_name
#           containerPort = local.container_port
#           hostPort      = local.container_port
#           protocol      = "tcp"
#         }
#       ]

#       readonly_root_filesystem = false

#       enable_cloudwatch_logging = true
#       logConfiguration = {
#         logDriver = "awsLogs"
#         options = {
#           awslogs-group         = "ecs/django-app",
#           awslogs-region        = "us-east-2",
#           awslogs-stream-prefix = "django-app-log-stream"
#         }
#       }
#       memory_reservation = 100
#     }
#   }

#   service_connect_configuration = {
#     namespace = aws_service_discovery_http_namespace.this.arn
#     service = {
#       client_alias = {
#         port     = local.container_port
#         dns_name = local.container_name
#       }
#       port_name      = local.container_name
#       discovery_name = local.container_name
#     }
#   }

#   load_balancer = {
#     service = {
#       target_group_arn = module.alb.target_groups["ex_ecs"].arn
#       container_name   = local.container_name
#       container_port   = local.container_port
#     }
#   }

#   subnet_ids = module.default_aws_networking.private_subnets
#   security_group_rules = {
#     alb_ingress_8000 = {
#       type                     = "ingress"
#       from_port                = local.container_port
#       to_port                  = local.container_port
#       protocol                 = "tcp"
#       description              = "Service port"
#       source_security_group_id = module.alb.security_group_id
#     }
#     egress_all = {
#       type        = "egress"
#       from_port   = 0
#       to_port     = 0
#       protocol    = "-1"
#       cidr_blocks = ["0.0.0.0/0"]
#     }
#   }

#   service_tags = {
#     "ServiceTag" = "Tag on service level"
#   }

#   tags = local.tags
# }

# resource "aws_service_discovery_http_namespace" "this" {
#   name        = local.name
#   description = "CloudMap namespace for ${local.name}"
#   tags        = local.tags
# }

# ##################################################################################
# # ALB
# ##################################################################################
# module "alb" {
#   source  = "terraform-aws-modules/alb/aws"
#   version = "~> 9.0"

#   name = local.name

#   load_balancer_type = "application"

#   vpc_id  = module.default_aws_networking.vpc_id
#   subnets = module.default_aws_networking.public_subnets

#   # For example only
#   enable_deletion_protection = false

#   # Security Group
#   security_group_ingress_rules = {
#     all_http = {
#       from_port   = 80
#       to_port     = 80
#       ip_protocol = "tcp"
#       cidr_ipv4   = "0.0.0.0/0"
#     }
#   }
#   security_group_egress_rules = {
#     all = {
#       ip_protocol = "-1"
#       cidr_ipv4   = module.default_aws_networking.vpc_cidr_block
#     }
#   }

#   listeners = {
#     ex_http = {
#       port     = 80
#       protocol = "HTTP"

#       forward = {
#         target_group_key = "ex_ecs"
#       }
#     }
#   }

#   target_groups = {
#     ex_ecs = {
#       backend_protocol                  = "HTTP"
#       backend_port                      = 80
#       target_type                       = "ip"
#       deregistration_delay              = 5
#       load_balancing_cross_zone_enabled = true

#       health_check = {
#         enabled             = true
#         healthy_threshold   = 5
#         interval            = 30
#         matcher             = "200"
#         path                = "/"
#         port                = "traffic-port"
#         protocol            = "HTTP"
#         timeout             = 5
#         unhealthy_threshold = 2
#       }

#       # Theres nothing to attach here in this definition. Instead,
#       # ECS will attach the IPs of the tasks to this target group
#       create_attachment = false
#     }
#   }

#   tags = local.tags
# }
