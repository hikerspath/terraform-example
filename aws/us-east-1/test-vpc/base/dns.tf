#
# Setup VPC DNS
#
module "zones" {
  source  = "terraform-aws-modules/route53/aws//modules/zones"
  version = "~> 2.0"

  tags = local.base_tags

  zones = {
    "${module.vpc.name}.internal" = {
      comment = "Internal DNS for ${module.vpc.name}"
      tags = { 
        Type = "Internal"
      }
      vpc = [
        { vpc_id = module.vpc.vpc_id }
      ]
    }
  }
}
