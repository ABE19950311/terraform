resource "aws_lb" "main" {
  name               = "main"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb.id]
  #lb自身は冗長化したパブリックサブネットに配置する
  #ターゲット先インスタンスのサブネットを指定するわけではない
  #https://qiita.com/hatahatahata/items/9bb67aabe2282b38b029
  subnets            = [aws_subnet.alb1.id, aws_subnet.alb2.id]

  tags = {
    Environment = "main"
  }
}

resource "aws_lb_listener" "main" {
  load_balancer_arn = aws_lb.main.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.main.arn
  }
}

resource "aws_lb_listener_rule" "main" {
  listener_arn = aws_lb_listener.main.arn
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.main.arn
  }

  condition {
    path_pattern {
      values = ["/*"]
    }
  }
}

resource "aws_lb_target_group" "main" {
  name     = "main"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id
}

///ターゲットグループをインスタンスに紐づける
resource "aws_lb_target_group_attachment" "private1" {
  target_group_arn = aws_lb_target_group.main.arn
  target_id        = aws_instance.private1.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "private2" {
  target_group_arn = aws_lb_target_group.main.arn
  target_id        = aws_instance.private2.id
  port             = 80
}