################################################################
# AWS ECS-EC2 AGENT CREATION FOR EXPERIENCE SEARCH ENGINE (XSE)
################################################################
resource "aws_instance" "xse_ec2_instance" {
  ami                    = var.ec2_ami
  subnet_id              = aws_subnet.xse_subnet1_useast1.id
  instance_type          = local.xse.ec2_instance_type
  iam_instance_profile   = local.ecs_instance_profile
  vpc_security_group_ids = [aws_security_group.ecc_xse_sg.id]
  key_name               = var.ec2_key_name
  ebs_optimized          = "false"
  source_dest_check      = "false"
  user_data              = data.template_file.xse_user_data.rendered
  root_block_device {
    volume_type           = local.xse.ec2_volume_type
    volume_size           = local.xse.ec2_volume_size
    delete_on_termination = "true"
  }

  tags = {
    Name                   = local.xse.ec2_instance_name
}

  lifecycle {
    ignore_changes         = [ami, user_data, subnet_id, key_name, ebs_optimized, private_ip]
  }
}

data "template_file" "xse_user_data" {
  template = file("templates/openlxp_xse_userdata.tpl")
}