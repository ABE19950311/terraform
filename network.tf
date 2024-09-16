#vpc
resource "aws_vpc" "main" {
  cidr_block = "10.100.0.0/16"

  tags = {
    Name = "main"
  }
}

#internete gateway
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "main"
  }
}

#public subnet
resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.100.10.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "public"
  }
}
#private subnet
# resource "aws_subnet" "private" {
#   vpc_id     = aws_vpc.main.id
#   cidr_block = "10.100.20.0/24"

#   tags = {
#     Name = "private"
#   }
# }

#public route table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name = "default_gateway"
  }
}

#private route table
# resource "aws_route_table" "private" {
#   vpc_id = aws_vpc.main.id

#   route {
#     cidr_block = "0.0.0.0/0"
#     gateway_id = aws_nat_gateway.main.id
#   }

#   tags = {
#     Name = "default_gateway"
#   }
# }

#public route table associate
resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}
#private route table associate
# resource "aws_route_table_association" "private" {
#   subnet_id      = aws_subnet.private.id
#   route_table_id = aws_route_table.private.id
# }

#public security group
resource "aws_security_group" "public" {
  vpc_id = aws_vpc.main.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

#private security group
# resource "aws_security_group" "private" {
#   vpc_id = aws_vpc.main.id

#   ingress {
#     from_port   = 22
#     to_port     = 22
#     protocol    = "tcp"
#     cidr_blocks = ["10.100.10.0/24"]
#   }
#   ingress {
#     from_port   = 80
#     to_port     = 80
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
#   ingress {
#     from_port   = 443
#     to_port     = 443
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
# }

#key pair
resource "aws_key_pair" "main" {
  key_name   = "id_rsa"
  public_key = file("~/.ssh/id_rsa.pub")
}

#nat_gateway eip
# resource "aws_eip" "nat_gateway" {
#   domain     = "vpc"
#   #インターネットゲートウェイ構築後に作ることを明示的に示す
#   depends_on = [aws_internet_gateway.main]
# }

# #nat gateway
# resource "aws_nat_gateway" "main" {
#   allocation_id = aws_eip.nat_gateway.id
#   subnet_id     = aws_subnet.public.id
#   #インターネットゲートウェイ構築後に作ることを明示的に示す
#   depends_on    = [aws_internet_gateway.main]

#   tags = {
#     Name = "main"
#   }
# }