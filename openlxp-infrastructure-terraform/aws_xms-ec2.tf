##################################################################
# AWS ECS-EC2 AGENT CREATION FOR:
# EXPERIENCE MANAGEMENT SERVICE (XMS)
# EXPERIENCE MANAGEMENT SERVICE UI (XMS/XMSUI)
#################################################################
resource "aws_instance" "xms_ec2_instance" {
  ami                    = var.ec2_ami
  subnet_id              = aws_subnet.xms_subnet1_useast1.id
  instance_type          = local.xms.ec2_instance_type
  iam_instance_profile   = local.ecs_instance_profile
  vpc_security_group_ids = [aws_security_group.ecc_openlxpui_sg.id]
  key_name               = var.ec2_key_name
  ebs_optimized          = "false"
  source_dest_check      = "false"
  user_data              = data.template_file.xms_user_data.rendered
  root_block_device {
    volume_type           = local.xms.ec2_volume_type
    volume_size           = local.xms.ec2_volume_size
    delete_on_termination = "true"
  }

  tags = {
    Name                   = local.xms.ec2_instance_name
}

  lifecycle {
    ignore_changes         = [ami, user_data, subnet_id, key_name, ebs_optimized, private_ip]
  }
}

data "template_file" "xms_user_data" {
  template = file("templates/openlxp_xms_userdata.tpl")
}