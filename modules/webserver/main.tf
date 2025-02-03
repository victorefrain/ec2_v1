#resource "aws_instance" "webserver" {
#  ami           = var.ami
#  instance_type = var.instance_type
#  subnet_id     = var.subnet_id
#  security_groups = [var.security_group_id]
#
#  user_data = templatefile("${path.module}/install_webserver.sh", {})
#
#  tags = {
#    Name = "webserver"
#  }
#}
#
#output "public_ip" {
#  value = aws_instance.webserver.public_ip
#}



resource "aws_instance" "webserver" {
  ami           = var.ami
  instance_type = var.instance_type
  subnet_id     = var.subnet_id
  security_groups = [var.security_group_id]

  user_data = templatefile("${path.module}/install_webserver.sh", {})

  tags = {
    Name = "webserver"
  }
}

resource "aws_lb_target_group_attachment" "webserver_attachment" {
  #target_group_arn = module.load_balancer.aws_lb_target_group.example.arn
  target_group_arn = var.target_group_arn
  target_id        = aws_instance.webserver.id
  port             = 80
}

output "public_ip" {
  value = aws_instance.webserver.public_ip
}

