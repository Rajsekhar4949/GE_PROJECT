variable "region" {
  default = "us-east-1"
}

variable "cluster_id" {
  default = "cluster-example"
}

variable "engine" {
  default = "redis"
}

variable "node_type" {
  default = "cache.m3.medium"
}

variable "num_cache_nodes" {
  default = "1"
}

variable "parameter_group_name" {
  default = "default-redis"
}

variable "private_subnet_id" {
  type = "list"
}

variable "sns_notification_arn" {}

#Parameter Group
variable "parameter_family" {
  default = "redis3.2"
}

variable "parameter_name" {
  default = "activerehashing"
}

variable "parameter_value" {
  default = "yes"
}

#Replication Group

variable "replica_group_id" {
  default = "test-rep-group"
}

variable "replica_group_desc" {
  default = "test description"
}

variable "num_cache_clusters" {
  default = "2"
}

#Security Group
variable "security_group_name" {
  default = "test-security-group"
}

variable "elasti_security_grp_name" {
  default = "elasticache-security-group"
}

#Subnet Group
variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "subnet_cidr" {
  default = "10.0.0.0/24"
}

variable "aws_zone" {
  default = "us-east-1a"
}

variable "elasti_subnet_grp_name" {
  default = "test-cache-subnet"
}

variable "private_security_list_id" {
  type = "list"
}
