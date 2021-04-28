locals {
  base_tags = {
    ManagedBy = "Terraform"
    Owner     = "me"
    Vpc       = "test-vpc"
  }
  hosts = 1
}
