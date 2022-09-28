resource "aws_alb" "lb_votation" {

  name               = "lb_votation"
  internal           = true
  load_balancer_type = "application"
  security_groups    = aws_security_group.alb_security_gp.id
  subnets            = [for subnet in aws_subnet.private : subnet.id]

  tags = {
    "project_votation" = "${local.votation_tag}"
  }
}