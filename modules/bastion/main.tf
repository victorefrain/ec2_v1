resource "aws_instance" "bastion" {
  ami           = var.ami
  instance_type = var.instance_type
  subnet_id     = var.subnet_id
  security_groups = [var.security_group_id]

  tags = {
    Name = "bastion"
  }
}

output "public_ip" {
  value = aws_instance.bastion.public_ip
}
