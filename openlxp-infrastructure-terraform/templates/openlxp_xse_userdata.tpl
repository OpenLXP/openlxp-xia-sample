#!/bin/bash

# Update all packages

sudo yum update -y
sudo yum install docker.io -y
sudo yum install -y ecs-init
sudo yum install --y https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/linux_amd64/amazon-ssm-agent.rpm
sudo yum install -y polkit
sysctl -w vm.max_map_count=262144
sudo service docker start
sudo start ecs

#Adding cluster name in ecs config
echo ECS_CLUSTER=openlxp-ecc_XSECluster >> /etc/ecs/ecs.config
cat /etc/ecs/ecs.config | grep "ECS_CLUSTER"