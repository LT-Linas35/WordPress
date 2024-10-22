# AWS ElastiCache Cluster for Redis
resource "aws_elasticache_cluster" "redis" {
  cluster_id           = var.cluster_id                                      # The identifier for the Redis cluster.
  engine               = var.engine                                          # The cache engine to use for the Redis cluster (e.g., redis).
  node_type            = var.node_type                                       # The instance type for the Redis nodes (e.g., cache.t2.micro).
  num_cache_nodes      = var.num_cache_nodes                                 # The number of cache nodes for the Redis cluster.
  parameter_group_name = var.parameter_group_name                            # The name of the parameter group for the Redis cluster.
  port                 = var.port                                            # The port number on which the Redis cluster will accept connections.
  subnet_group_name    = var.aws_elasticache_subnet_group_redis_subnet_group # The name of the subnet group to associate with the Redis cluster.
  security_group_ids   = [var.aws_security_group_redis_sg]                   # The security group(s) to associate with the Redis cluster.

  tags = {
    Name        = var.aws_elasticache_cluster_redis_name # The name tag for the AWS ElastiCache cluster used for Redis
    Environment = var.Environment                        # You can customize this tag to reflect the environment
    ManagedBy   = var.ManagedBy                          # Helps to track which tool is managing this resource
  }
}
