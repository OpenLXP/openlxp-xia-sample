############################################################
# SG TO ALLOW INBOUND CONNECTION ON PORTS 9200,
# & 443/80 FOR:
# EXPERIENCE SEARCH ENGINE (XSE)
#########################################################
resource "aws_security_group" "ecc_xse_sg" {
  name                      = local.xse.sg_name
  description               = "Allow TLS inbound traffic on ports 8010, 8020, 3306, 443, & 80 "
  vpc_id                    = data.aws_vpc.openlxp_vpc.id

  ingress {
      description             = "public ip to test"
      from_port               = 0
      to_port                 = 65535
      protocol                = "tcp"
      cidr_blocks             = [local.my_pub_ip]
  }

  ingress {
    description             = "XSE host/container port"
    from_port               = 9200
    to_port                 = 9200
    protocol                = "tcp"
    cidr_blocks             = [var.vpc_cidr_block]
  }

  ingress {
    description             = "Kibana host/container port"
    from_port               = 5601
    to_port                 = 5601
    protocol                = "tcp"
    cidr_blocks             = [var.vpc_cidr_block]
  }

  ingress {
    description           = "All Traffic in XSE Sg"
    from_port             = 0
    to_port               = 65535
    protocol              = "tcp"
    self                  = true
  }

  ingress {
    description             = "HTTPS"
    from_port               = 443
    to_port                 = 443
    protocol                = "tcp"
    cidr_blocks             = ["0.0.0.0/0"]
  }

  ingress {
    description             = "HTTP"
    from_port               = 80
    to_port                 = 80
    protocol                = "tcp"
    cidr_blocks             = ["0.0.0.0/0"]
  }

  egress {
    from_port               = 0
    to_port                 = 0
    protocol                = "-1"
    cidr_blocks             = ["0.0.0.0/0"]
  }

  tags = {
    Name                    = local.xse.sg_name
  }
}

