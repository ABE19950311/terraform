#https://blog.manabusakai.com/2020/03/elasticache-for-redis-with-terraform/
#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticache_cluster
#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticache_subnet_group
#https://qiita.com/charon/items/53790d8826e32561535d

resource "aws_elasticache_replication_group" "example" {
  replication_group_id          = "example"
  replication_group_description = "example"
  node_type                     = "cache.t3.micro"
  number_cache_clusters         = 2
  automatic_failover_enabled    = true
  engine_version                = "5.0.6"
  parameter_group_name          = "default.redis5.0"
  security_group_ids = [module.elasticache_for_redis_cluster_sg.this_security_group_id]
  subnet_group_name  = aws_elasticache_subnet_group.redis_subnet.name
}

resource "aws_elasticache_subnet_group" "bar" {
  name       = "tf-test-cache-subnet"
  subnet_ids = [aws_subnet.foo.id]
}