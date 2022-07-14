variable "lb_sg_id" {
  type = string
}

variable "public_subnet_ids" {
  type = list
  
}
variable "vpc_id" {
  type = string
  
}

variable "instance_id" {
 type =string 
}

resource "aws_lb_target_group" "test_tg" {
  name     = "tf-example-lb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

resource "aws_lb_target_group_attachment" "test_tg_attachment" {
  target_group_arn = aws_lb_target_group.test_tg.arn
  target_id        = var.instance_id
  port             = 80
}


resource "aws_lb" "test" {
  name               = "test-lb-tf"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.lb_sg_id]
  subnets            = var.public_subnet_ids
  tags = {
    Environment = "dev"
  }
}


resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.test.arn
  port              = "80"
  protocol          = "HTTP"
  # ssl_policy        = "ELBSecurityPolicy-2016-08"
  # certificate_arn   = "arn:aws:iam::187416307283:server-certificate/test_cert_rab3wuqwgja25ct3n4jdj2tzu4"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.test_tg.arn
  }
}

output "loadbalancer_dns" {
  value = aws_lb.test.dns_name
}