#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_instance
# resource "aws_db_instance" "rds" {
#   allocated_storage       = 10
#   backup_retention_period = 7
#   db_subnet_group_name    = aws_db_subnet_group.dbsubnet.name
#   vpc_security_group_ids  = [aws_security_group.rds.id]
#   engine                  = "mysql"
#   engine_version          = "8.0.35"
#   instance_class          = "db.t3.micro"
#   multi_az                = true
#   password                = "hogehoge"
#   username                = "hogeUser"
#   storage_encrypted       = true
#   skip_final_snapshot     = true

#   timeouts {
#     create = "3h"
#     delete = "3h"
#     update = "3h"
#   }
# }

#https://qiita.com/sicksixrock66/items/63c6b651e6ccc28b0285
#https://zenn.dev/suganuma/articles/fe14451aeda28f
#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_subnet_group
# resource "aws_db_subnet_group" "dbsubnet" {
#   name       = "main"
#   subnet_ids = [aws_subnet.rds1.id, aws_subnet.rds2.id]

#   tags = {
#     Name = "My DB subnet group"
#   }
# }