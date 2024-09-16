#public
resource "aws_instance" "publc" {
  ami                    = "ami-09a76e2a3c19fb6ca"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.public.id
  key_name               = aws_key_pair.main.id
  vpc_security_group_ids = [aws_security_group.public.id]

  tags = {
    Name = "public"
  }
}


#private
# resource "aws_instance" "private" {
#   ami                    = "ami-09a76e2a3c19fb6ca"
#   instance_type          = "t2.micro"
#   subnet_id              = aws_subnet.private.id
#   key_name               = aws_key_pair.main.id
#   vpc_security_group_ids = [aws_security_group.private.id]

#   tags = {
#     Name = "private"
#   }
# }