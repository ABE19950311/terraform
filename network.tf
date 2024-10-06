# #vpc
# resource "aws_vpc" "main" {
#   cidr_block = "10.100.0.0/16"

#   tags = {
#     Name = "main"
#   }
# }

# #internete gateway
# resource "aws_internet_gateway" "main" {
#   vpc_id = aws_vpc.main.id

#   tags = {
#     Name = "main"
#   }
# }

# #public subnet
# resource "aws_subnet" "bastion" {
#   vpc_id                  = aws_vpc.main.id
#   cidr_block              = "10.100.10.0/24"
#   map_public_ip_on_launch = true

#   tags = {
#     Name = "bastion"
#   }
# }
# #tmp public subnet
# resource "aws_subnet" "tmp_pub" {
#   vpc_id                  = aws_vpc.main.id
#   cidr_block              = "10.100.80.0/24"
#   map_public_ip_on_launch = true

#   tags = {
#     Name = "tmp_pub"
#   }
# }


# #alb subnet
# # resource "aws_subnet" "alb1" {
# #   vpc_id     = aws_vpc.main.id
# #   cidr_block = "10.100.40.0/24"

# #   tags = {
# #     Name = "alb1"
# #   }
# # }
# # #alb subnet
# # resource "aws_subnet" "alb2" {
# #   vpc_id     = aws_vpc.main.id
# #   cidr_block = "10.100.50.0/24"

# #   tags = {
# #     Name = "alb2"
# #   }
# # }
# #private subnet
# # resource "aws_subnet" "private1" {
# #   vpc_id            = aws_vpc.main.id
# #   cidr_block        = "10.100.20.0/24"
# #   availability_zone = "ap-northeast-1a"

# #   tags = {
# #     Name = "private1"
# #   }
# # }

# # resource "aws_subnet" "private2" {
# #   vpc_id            = aws_vpc.main.id
# #   cidr_block        = "10.100.30.0/24"
# #   availability_zone = "ap-northeast-1c"

# #   tags = {
# #     Name = "private2"
# #   }
# # }

# # rds subnet
# # resource "aws_subnet" "rds1" {
# #   vpc_id     = aws_vpc.main.id
# #   cidr_block = "10.100.60.0/24"
# #   availability_zone = "ap-northeast-1a"

# #   tags = {
# #     Name = "rds1"
# #   }
# # }

# # resource "aws_subnet" "rds2" {
# #   vpc_id     = aws_vpc.main.id
# #   cidr_block = "10.100.70.0/24"
# #   availability_zone = "ap-northeast-1c"

# #   tags = {
# #     Name = "rds2"
# #   }
# # }

# #public route table
# resource "aws_route_table" "bastion" {
#   vpc_id = aws_vpc.main.id

#   route {
#     cidr_block = "0.0.0.0/0"
#     gateway_id = aws_internet_gateway.main.id
#   }

#   tags = {
#     Name = "default_gateway"
#   }
# }
# # resource "aws_route_table" "alb" {
# #   vpc_id = aws_vpc.main.id

# #   route {
# #     cidr_block = "0.0.0.0/0"
# #     gateway_id = aws_internet_gateway.main.id
# #   }

# #   tags = {
# #     Name = "default_gateway"
# #   }
# # }

# #private route table
# # resource "aws_route_table" "private" {
# #   vpc_id = aws_vpc.main.id

# #   route {
# #     cidr_block = "0.0.0.0/0"
# #     gateway_id = aws_nat_gateway.main.id
# #   }

# #   tags = {
# #     Name = "default_gateway"
# #   }
# # }

# #public route table associate
# resource "aws_route_table_association" "public" {
#   subnet_id      = aws_subnet.bastion.id
#   route_table_id = aws_route_table.bastion.id
# }
# resource "aws_route_table_association" "tmp_pub" {
#   subnet_id      = aws_subnet.tmp_pub.id
#   route_table_id = aws_route_table.bastion.id
# }
# # resource "aws_route_table_association" "alb1" {
# #   subnet_id      = aws_subnet.alb1.id
# #   route_table_id = aws_route_table.alb.id
# # }
# # resource "aws_route_table_association" "alb2" {
# #   subnet_id      = aws_subnet.alb2.id
# #   route_table_id = aws_route_table.alb.id
# # }
# #private route table associate
# # resource "aws_route_table_association" "private1" {
# #   subnet_id      = aws_subnet.private1.id
# #   route_table_id = aws_route_table.private.id
# # }
# # resource "aws_route_table_association" "private2" {
# #   subnet_id      = aws_subnet.private2.id
# #   route_table_id = aws_route_table.private.id
# # }

# #public security group
# resource "aws_security_group" "bastion" {
#   vpc_id = aws_vpc.main.id

#   ingress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
# }

# #private security group
# # resource "aws_security_group" "private" {
# #   vpc_id = aws_vpc.main.id

# #   ingress {
# #     from_port   = 22
# #     to_port     = 22
# #     protocol    = "tcp"
# #     cidr_blocks = ["10.100.10.0/24"]
# #   }
# #   ingress {
# #     from_port   = 80
# #     to_port     = 80
# #     protocol    = "tcp"
# #     cidr_blocks = ["0.0.0.0/0"]
# #   }
# #   ingress {
# #     from_port   = 443
# #     to_port     = 443
# #     protocol    = "tcp"
# #     cidr_blocks = ["0.0.0.0/0"]
# #   }

# #   egress {
# #     from_port   = 0
# #     to_port     = 0
# #     protocol    = "-1"
# #     cidr_blocks = ["0.0.0.0/0"]
# #   }
# # }

# #alb security group
# # resource "aws_security_group" "alb" {
# #   vpc_id = aws_vpc.main.id

# #   ingress {
# #     from_port   = 80
# #     to_port     = 80
# #     protocol    = "tcp"
# #     cidr_blocks = ["0.0.0.0/0"]
# #   }
# #   egress {
# #     from_port   = 0
# #     to_port     = 0
# #     protocol    = "-1"
# #     cidr_blocks = ["0.0.0.0/0"]
# #   }
# # }

# # rds security group 
# # resource "aws_security_group" "rds" {
# #   vpc_id = aws_vpc.main.id

# #   ingress {
# #     from_port   = 3306
# #     to_port     = 3306
# #     protocol    = "tcp"
# #     cidr_blocks = ["10.100.10.0/24"]
# #   }
# #   egress {
# #     from_port   = 0
# #     to_port     = 0
# #     protocol    = "-1"
# #     cidr_blocks = ["0.0.0.0/0"]
# #   }
# # }

# # nfs 
# resource "aws_security_group" "nfs" {
#   vpc_id = aws_vpc.main.id

#   ingress {
#     from_port   = 2049
#     to_port     = 2049
#     protocol    = "tcp"
#     cidr_blocks = ["10.100.0.0/16"]
#   }
#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
# }

# #key pair
# resource "aws_key_pair" "main" {
#   key_name   = "id_rsa"
#   public_key = file("~/.ssh/id_rsa.pub")
# }

# #nat_gateway eip
# # resource "aws_eip" "nat_gateway" {
# #   domain = "vpc"
# #   #インターネットゲートウェイ構築後に作ることを明示的に示す
# #   depends_on = [aws_internet_gateway.main]
# # }

# #nat gateway
# # resource "aws_nat_gateway" "main" {
# #   allocation_id = aws_eip.nat_gateway.id
# #   subnet_id     = aws_subnet.bastion.id
# #   #インターネットゲートウェイ構築後に作ることを明示的に示す
# #   depends_on = [aws_internet_gateway.main]

# #   tags = {
# #     Name = "main"
# #   }
# # }