#
# KMS: Encrypted Instance Password
#
data "aws_kms_secrets" "credentials" {
  secret {
    name    = "local_password"
    payload = "__REDACTED__"
  }
}

#
# USER_DATA: Cloud Init Scripting
#
data "template_file" "user_data" {
  template = file("user_data.yaml")

  vars = {
    local_login    = "demo"
    local_name     = "Demo User"
    local_password = data.aws_kms_secrets.credentials.plaintext["local_password"]
  }
}

#
# EC2 Instance
#
resource "aws_instance" "box" {
  ami                    = module.globals.global_aws_ami_amzn_linux2.image_id
  instance_type          = "t2.micro"
  user_data              = data.template_file.user_data.rendered
  availability_zone      = element(module.globals.global_aws_availability_zones_all.names, 0)
  vpc_security_group_ids = [aws_security_group.ssh.id]
  subnet_id              = data.aws_subnet.public[element(module.globals.global_aws_availability_zones_all.names, 0)].id

  associate_public_ip_address = true

  tags = merge(
    { "Name"  = "public-box" },
    local.base_tags
  )
}

output "instances" {
  value = [aws_instance.box.public_ip]
}
