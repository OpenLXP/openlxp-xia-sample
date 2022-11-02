################################################################################
# SG TO ALLOW INBOUND CONNECTION ON PORTS 8000/8100 (BACKEND),
# 3000 (UI), 443/80, & MySQL PORTS 3310/3306 FOR:
# EXPERIENCE MANAGEMENT SERVICE (XMS)
# EXPERIENCE MANAGEMENT SERVICE UI(XMS-UI)
# EXPERIENCE DISCOVERY SERVICE (XDS)
# EXPERIENCE MANAGEMENT SERVICE UI
###############################################################################
resource "aws_security_group" "ecc_openlxpui_sg" {
  name                      = local.openlxpui_sg
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
    description             = "XMS/XDS container port"
    from_port               = 8020
    to_port                 = 8020
    protocol                = "tcp"
    cidr_blocks             = [var.vpc_cidr_block]
  }

  ingress {
    description             = "XMS host port"
    from_port               = 8000
    to_port                 = 8000
    protocol                = "tcp"
    cidr_blocks             = [var.vpc_cidr_block]
  }

  ingress {
    description             = "XDS host port"
    from_port               = 8100
    to_port                 = 8100
    protocol                = "tcp"
    cidr_blocks             = [var.vpc_cidr_block]
  }

  ingress {
    description             = "XMS/XDS UI port"
    from_port               = 3000
    to_port                 = 3000
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
    description           = "All Traffic in OPENLXPUI Sg"
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
    Name                    = local.openlxpui_sg
  }
}

