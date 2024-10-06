# #https://docs.aws.amazon.com/ja_jp/efs/latest/ug/how-it-works.html
# #https://qiita.com/wokamoto/items/c70b12ed104b23fd7188#efs-%E3%81%AE%E4%BD%9C%E6%88%90
# resource "aws_efs_file_system" "main" {
#   creation_token = "my-product"

#   tags = {
#     Name = "MyProduct"
#   }
# }

# resource "aws_efs_mount_target" "alpha" {
#   file_system_id  = aws_efs_file_system.main.id
#   subnet_id       = aws_subnet.tmp_pub.id
#   security_groups = [aws_security_group.nfs.id]
# }

# resource "aws_efs_mount_target" "beta" {
#   file_system_id  = aws_efs_file_system.main.id
#   subnet_id       = aws_subnet.bastion.id
#   security_groups = [aws_security_group.nfs.id]
# }