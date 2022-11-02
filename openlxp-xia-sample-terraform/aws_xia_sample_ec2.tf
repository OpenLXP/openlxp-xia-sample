################################################################
# AWS ECS-EC2 AGENT CREATION FOR EXPERIENCE INDEX AGENT MOODLE
################################################################
resource "aws_instance" "xia_sample_ec2_instance" {
  ami                    = var.ec2_ami
  subnet_id              =  aws_subnet.xia_sample_subnet1_useast1.id
  instance_type          = local.xia.sample.ec2_instance_type
  iam_instance_profile   = aws_iam_instance_profile.ecs-instance-profile.name
  vpc_security_group_ids = [aws_security_group.ecc_xia_sg.id]
  key_name               = var.ec2_key_name
  ebs_optimized          = "false"
  source_dest_check      = "false"
  user_data              = data.template_file.xia_sample_user_data.rendered
  root_block_device {
    volume_type           = local.xia.sample.ec2_volume_type
    volume_size           = local.xia.sample.ec2_volume_size
    delete_on_termination = "true"
  }

  tags = {
    Name                   = local.xia.sample.ec2_instance_name
}

  lifecycle {
    ignore_changes         = [ami, user_data, subnet_id, key_name, ebs_optimized, private_ip]
  }
}

data "template_file" "xia_sample_user_data" {
  template = file("templates/openlxp_xia_sample_userdata.tpl")
}