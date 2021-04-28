#
# VPC: Create VPC
#
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = local.base_tags["Vpc"]
  cidr = "10.254.0.0/21"

  azs                 = data.aws_availability_zones.all.names
  private_subnets     = ["10.254.1.0/24", "10.254.2.0/24", "10.254.3.0/24"]
  private_subnet_tags = { "Type" = "Private" }
  public_subnets      = ["10.254.4.0/24", "10.254.5.0/24", "10.254.6.0/24"]
  public_subnet_tags  = { "Type" = "Public" }

  enable_nat_gateway   = true
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = merge(
    { "Name" = local.base_tags["Vpc"] },
    local.base_tags
  )
}
