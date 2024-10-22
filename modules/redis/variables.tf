variable "aws_elasticache_subnet_group_redis_subnet_group" {
  description = "The name of the ElastiCache subnet group to use for Redis"
  type        = string
}

variable "aws_security_group_redis_sg" {
  description = "The security group to associate with the Redis cluster"
  type        = string
}

variable "cluster_id" {
  description = "The identifier for the Redis cluster."
  type        = string
}

variable "engine" {
  description = "The cache engine to use for the Redis cluster (e.g., redis)."
  type        = string
}

variable "node_type" {
  description = "The node type for the Redis cache cluster (e.g., cache.t4g.micro)."
  type        = string
}

variable "num_cache_nodes" {
  description = "The number of cache nodes for the Redis cluster."
  type        = number
}

variable "parameter_group_name" {
  description = "The name of the parameter group for the Redis cluster."
  type        = string
}

variable "port" {
  description = "The port on which the Redis cluster will accept connections."
  type        = number
}

variable "Environment" {
  description = "You can customize this tag to reflect the environment"
  type        = string
}

variable "ManagedBy" {
  description = "Helps to track which tool is managing this resource"
  type        = string
}

variable "aws_elasticache_cluster_redis_name" {
  description = "The name tag for the AWS ElastiCache cluster used for Redis"
  type        = string
}
