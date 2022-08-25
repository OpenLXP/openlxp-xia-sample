####################################
#PROVIDER VARS
####################################
variable "profile" {
  type                        = string
  default                     = "default"
}

variable "region" {
  type                        = string
  default                     = "us-east-1"
}

variable "environment" {
  default                     = "DEV"
}

####################################
# IAM VARS
####################################
variable "task_execution_role" {
  description                 = "task execution role for ecs"
  default                     = "openlxp-ecc_ECSTaskExecutionRole"
}

variable "ecs_iam_role_policy" {
  description                 = "iam policy for ecs"
  default                     = "openlxp_ecc_ECSRolePolicy"
}

variable "aws_secrets_policy" {
  description                 = "policy to allow aws secrets retrieval from ecs"
  default                     = "aws_secrets"
}

variable "ecs_role" {
  description                 = "iam role for ecs"
  default                     = "openlxp_ecc_ECSRole"
}

####################################
# VPC VARS
####################################
variable "vpc_name" {
  description                 = "name for openlxp-ecc vpc"
  default                     = "openlxp_vpc"
}

variable "vpc_sg_name" {
  description                 = "name for openlxp-ecc vpcs security group"
  default                     = "openlxp_vpc_SG"
}

variable "vpc_cidr_block" {
  description                 = "cidr block range for vpc"
  default                     = "10.0.0.0/16"
}

variable "vpc_igw" {
  description                 = "name for openlxp-ecc vpc internet gateway"
  default                     = "openlxp_ecc_IGW"
}

variable "vpc_route_table" {
  description                 = "name for openlxp-ecc vpc route table"
  default                     = "openlxp_ecc_RT"
}

####################################
# ECS-EC2 VARS
####################################
variable "cpu" {
  description                 = "Fargate instance CPU units to provision (1 vCPU = 1024 CPU units)"
  default                     = "1024"
}

variable "memory" {
  description                 = "Fargate instance memory to provision (in MiB)"
  default                     = "2048"
}

variable "ec2_ami" {
  description                 = "AMI for ecs-ec2 with ecs agent pre-installed"
  default                     = "ami-040d909ea4e56f8f3"
}

variable "ec2_key_name" {
  description                  = "Name of key pair for ec2 instance. Create before"
  default                      = "mytf-testKey"
}


