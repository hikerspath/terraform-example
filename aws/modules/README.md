# AWS Provider Modules

The modules here are locally maintained but make use of the AWS provider.

## Modules

Below are all of the modules created in here and a brief synopsis of how to use each.

### Globals

The purpose of globals is to provide a series of lookups and variables that can be called into terraform configs without having to duplicate code.  This can be done in two methods, the first through use of [default branch](https://www.terraform.io/docs/language/modules/sources.html#github), the second locked to a particular tag or hash.

**Usage**

```hcl
module "globals" {
  source = "../../../modules/globals"
}

Once the definition is completed, you can use use anything that is defined as an [output](https://www.terraform.io/docs/language/values/outputs.html) like this `module.globals.global_aws_availability_zones_all.names` to get all of the availability zones in your region.

## References

* https://registry.terraform.io/providers/hashicorp/aws/latest/docs
