#
# VPC: Create VPC
#
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = local.base_tags["Vpc"]
  cidr = "10.254.0.0/21"

  azs                 = module.globals.global_aws_availability_zones_all.names
  private_subnets     = ["10.254.1.0/24", "10.254.2.0/24", "10.254.3.0/24"]
  private_subnet_tags = { "Type" = "Private" }
  public_subnets      = ["10.254.4.0/24", "10.254.5.0/24", "10.254.6.0/24"]
  public_subnet_tags  = { "Type" = "Public" }

  enable_nat_gateway   = true
  enable_dns_hostnames = true
  enable_dns_support   = true

  enable_dhcp_options      = true
  dhcp_options_domain_name = "${local.base_tags["Vpc"]}.internal"

  tags = merge(
    { "Name" = local.base_tags["Vpc"] },
    local.base_tags
  )
}
