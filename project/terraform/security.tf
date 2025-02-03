
# Security group for EC2 instance
resource "aws_security_group" "ec2_sg" {
  name        = "allow_ssh_http"
  description = "Allow SSH and HTTP traffic"
  vpc_id      = "vpc-00ec4841e453b1748" # default VPC

  ingress {
    description = "TLS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # allow from all IPs
  }

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "TCP"
    from_port   = 3000 # for nodejs app
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Security group for EC2 instance (using terraform module)
# module "tf_ec2_module" {
#   source  = "terraform-aws-modules/security-group/aws"
#   version = "5.2.0"
#   vpc_id  = "" # default VPC
#   name    = "ec2-security-group"

#   ingress_cidr_blocks = [
#     {
#       from_port   = 3000
#       to_port     = 3000
#       protocol    = "tcp"
#       description = "for nodejs app"
#       cidr_blocks = "0.0.0.0/0"
#     },
#     {
#       rule        = "https-443-tcp"
#       cidr_blocks = "0.0.0.0/0"
#     },
#     {
#       rule        = "ssh-tcp"
#       cidr_blocks = "0.0.0.0/0"
#     },

#   ]
#   egress_rules = ["all-all"]
# }


# output
output "ec2_public_ip" {
  value = aws_instance.tf_server.public_ip
}
