#
# EC2: Security Group
#
resource "aws_security_group" "ssh" {
  vpc_id = data.aws_vpc.selected.id
  name   = "ssh-${local.base_tags["Vpc"]}"

  tags = merge(
    { "Name"  = "ssh-${local.base_tags["Vpc"]}" },
    local.base_tags
  )

  // Allow traffic within security group
  ingress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = [ data.aws_vpc.selected.cidr_block ]
  }

  // Allow SSH
  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = [ "0.0.0.0/0" ]
  }
}
