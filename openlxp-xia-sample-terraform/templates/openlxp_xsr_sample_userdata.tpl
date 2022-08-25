#! /bin/bash
sudo yum update -y
sudo yum install -y docker
sudo service docker start
sudo usermod -aG docker ec2-user

sudo docker pull openlxp/openlxp-xsr-sample:latest
sudo docker run -p 80:80 -d openlxp/openlxp-xsr-sample