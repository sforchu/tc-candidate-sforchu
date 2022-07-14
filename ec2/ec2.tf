resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC+cUHAB7CdT5ac+8Q7nK/vLestZWxt45gC7mM2dSaqU4r5OeVFcuLBpdq1VQaPcYYnJvxqpQYwYASN//PMvPrQrA5qqQTNQETUMg1V2esKUR7Q38Fslg1Ob0A/SCYCJ5/BCbw68uywHo2BJTwnZaeRh//qQRiweuUv+Ve87mEXGknBjBCueMO03MT1HPaq38SMQI+NxMCxer/gm6wLsknJyXNyhZ4xuz+gSgGCTB/fk2N+aIXafO6R7pTaSeFqPqtzSYOMIjTcSdnESEWRQQpErd2kG0snrATLBQ8HnQv1AZyLkSqnV3ADZrGAwP9ZEsY+fP7lpz+LITOiuLPv13Yz0Ugydl22wPRnUHOBKlHdH/6zifen4tXvm3ezML9qwN3qKiO/C+rjoP6vwHZ+8X+YOv3zzOyXK9wlzB4H5Uc0LtQt395otEzn3Mba8qf2uJgci8l3OnyFmHKSxAxKxPEKj8T/9grrhlW+SBRHso/gcx25zlFdjt31ACTa0UO4K+0="
}

variable "subnet_ids" {
    type  = list
}

variable "sg_id" {
  
}
variable "iam_role_name" {
  
}

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "ec2_profile"
  role = var.iam_role_name
}

resource "aws_instance" "app_server" {
  ami           = "ami-02d1e544b84bf7502"  
  instance_type = "t2.micro"
  key_name = aws_key_pair.deployer.key_name
  subnet_id         = var.subnet_ids[0]
  vpc_security_group_ids =[ var.sg_id]
  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name
  user_data = "${file("scripts/shell.sh")}"
  tags = {
    Name = "app-server"
  }
}

output "instance_id" {
  value = aws_instance.app_server.id
}