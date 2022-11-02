#########################################################
# SG TO ALLOW INBOUND CONNECTION ON PORTS 8020/8000,
# 443/80 & MySQL PORTS 3310/3306 FOR:
# XIA AGENTS
#########################################################
resource "aws_security_group" "ecc_xsr_sample_sg" {
  name                        = local.xsr_sample.xsr_sample_sg
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
    description             = "nginx port"
    from_port               = 80
    to_port                 = 80
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
    Name                    = local.xsr_sample.xsr_sample_sg
  }
}

