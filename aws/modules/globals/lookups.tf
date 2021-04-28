# DL: Availability Zone List
data "aws_availability_zones" "all" {}

# DL: Latest Amazon Linux 2 AMI
data "aws_ami" "amzn" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-*-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

output "aws_availability_zones_all" {
  value = data.aws_availability_zones.all
}
