#########################################################
# SG TO ALLOW INBOUND CONNECTION ON PORTS 8020/8000,
# 443/80 & MySQL PORTS 3310/3306 FOR:
# XIA SAMPLE AGENT
#########################################################
resource "aws_security_group" "ecc_xia_sg" {
  name                        = local.xia.sg_name
  description                 = "Allow TLS inbound traffic on ports 8010, 8020, 3306, 443, & 80 "
  vpc_id                      = aws_vpc.openlxp_ecc_vpc.id

  ingress {
      description             = "public ip to test"
      from_port               = 0
      to_port                 = 65535
      protocol                = "tcp"
      cidr_blocks             = [local.my_pub_ip]
  }

  ingress {
    description             = "XIA container port"
    from_port               = 8020
    to_port                 = 8020
    protocol                = "tcp"
    cidr_blocks             = [aws_vpc.openlxp_ecc_vpc.cidr_block]
  }

  ingress {
    description             = "XIA host port"
    from_port               = 8000
    to_port                 = 8000
    protocol                = "tcp"
    cidr_blocks             = [aws_vpc.openlxp_ecc_vpc.cidr_block]
  }

  ingress {
    description             = "MYSQL DB host port"
    from_port               = 3306
    to_port                 = 3306
    protocol                = "tcp"
    cidr_blocks             = [aws_vpc.openlxp_ecc_vpc.cidr_block]
  }

  ingress {
    description             = "All Traffic in XIA Sg"
    from_port               = 0
    to_port                 = 65535
    protocol                = "tcp"
    self                    = true
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
    Name                    = local.xia.sg_name
  }
}

