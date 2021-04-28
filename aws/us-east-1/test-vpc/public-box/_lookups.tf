# DL: VPC
data "aws_vpc" "selected" {
  tags = {
    Name = local.base_tags["Vpc"]
  }
}

# DL: Public Subnets
data "aws_subnet" "public" {
  for_each = toset(module.globals.global_aws_availability_zones_all.names)

  availability_zone = each.key
  vpc_id            = data.aws_vpc.selected.id

  tags = {
    Type = "Public"
  }
}
