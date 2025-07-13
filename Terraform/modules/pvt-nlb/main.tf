resource "aws_lb" "this" {
  name               = var.nlb_name
  internal           = var.internal
  load_balancer_type = "network"
  subnets            = var.private_subnet_ids
}

resource "aws_lb_listener" "tcp_udp" {
  load_balancer_arn = aws_lb.this.arn
  port              = 4059
  protocol          = "TCP_UDP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }
}

resource "aws_lb_target_group" "tg" {
  name     = "${var.nlb_name}-tg"
  port     = 4059
  protocol = "TCP_UDP"
  vpc_id   = var.vpc_id

  stickiness {
    type    = "source_ip"
    enabled = true
  }

load_balancing_cross_zone_enabled = true
}
