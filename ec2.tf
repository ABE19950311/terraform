# #public
# resource "aws_instance" "bastion" {
#   ami                    = "ami-09a76e2a3c19fb6ca"
#   instance_type          = "t2.micro"
#   subnet_id              = aws_subnet.bastion.id
#   key_name               = aws_key_pair.main.id
#   vpc_security_group_ids = [aws_security_group.bastion.id]

#   tags = {
#     Name = "bastion"
#   }
# }

# #tmp pub
# resource "aws_instance" "tmp_pub" {
#   ami                    = "ami-09a76e2a3c19fb6ca"
#   instance_type          = "t2.micro"
#   subnet_id              = aws_subnet.tmp_pub.id
#   key_name               = aws_key_pair.main.id
#   vpc_security_group_ids = [aws_security_group.bastion.id]

#   tags = {
#     Name = "tmp_pub"
#   }
# }

# #private
# # resource "aws_instance" "private1" {
# #   ami                    = "ami-09a76e2a3c19fb6ca"
# #   instance_type          = "t2.micro"
# #   subnet_id              = aws_subnet.private1.id
# #   key_name               = aws_key_pair.main.id
# #   vpc_security_group_ids = [aws_security_group.private.id]

# #   tags = {
# #     Name = "private1"
# #   }
# # }

# # resource "aws_instance" "private2" {
# #   ami                    = "ami-09a76e2a3c19fb6ca"
# #   instance_type          = "t2.micro"
# #   subnet_id              = aws_subnet.private2.id
# #   key_name               = aws_key_pair.main.id
# #   vpc_security_group_ids = [aws_security_group.private.id]

# #   tags = {
# #     Name = "private2"
# #   }
# # }