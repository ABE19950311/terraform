#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record
#https://zenn.dev/kou_kawa/articles/19-terraform-aws-route53
resource "aws_route53_zone" "dev" {
  name = "dev.example.com"

  tags = {
    Environment = "dev"
  }
}

resource "aws_route53_record" "www" {
  zone_id = aws_route53_zone.primary.zone_id
  name    = "www.example.com"
  type    = "A"
  ttl     = 300
  records = [aws_eip.lb.public_ip]
}