############################################################
# SG TO ALLOW INBOUND CONNECTION ON PORTS 8010/8020,
# 443/80 & MySQL PORTS 3310/3306 FOR:
# EXPERIENCE SCHEMA SERVICE (XSS)
############################################################
resource "aws_security_group" "ecc_xss_sg" {
  name                      = local.xss.sg_name
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
    description             = "XSS container port"
    from_port               = 8010
    to_port                 = 8010
    protocol                = "tcp"
    cidr_blocks             = [var.vpc_cidr_block]
  }

  ingress {
    description             = "XSS host port"
    from_port               = 8020
    to_port                 = 8020
    protocol                = "tcp"
    cidr_blocks             = [var.vpc_cidr_block]
  }

  ingress {
    description           = "MYSQL DB host port"
    from_port             = 3306
    to_port               = 3306
    protocol              = "tcp"
    cidr_blocks           = [var.vpc_cidr_block]
  }

  ingress {
    description           = "MYSQL DB container port"
    from_port             = 3310
    to_port               = 3310
    protocol              = "tcp"
    cidr_blocks           = [var.vpc_cidr_block]
  }

  ingress {
    description           = "All Traffic in XSS Sg"
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
    Name                    = local.xss.sg_name
  }
}

