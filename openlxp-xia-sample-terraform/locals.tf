locals {
  my_pub_ip                         = "144.121.254.146/32" #include the /32 after IP address
  s3_bucket_name                    = "openlxp-ecc-var-bucket"
  xsr_sample = {
    xsr_sample_ec2_name             = "openlxp-ecc_XSR_SAMPLEInstance"
    xsr_sample_ec2_ami              = "ami-040d909ea4e56f8f3"
    xsr_sample_sg                   = "xsr_sample_SG"
    subnet1_name                    = "xsr_sample_subnet1_useast1"
    subnet1_cidr_block              = "10.0.52.0/24"
    ec2_instance_type               = "t2.medium"
    ec2_volume_size                 = "50"
    ec2_volume_type                 = "gp2"
  }
  xia = {
    sg_name                         = "openlxp_xia_sample_SG"
    sample = {
      app_container_name            = "app_xia_sample"
      container_db_name             = "db_xia_sample"
      cloudwatch_log_group_name     = "openlxp_ecc-xia_sample"
      cloudwatch_application        = "openlxp_ecc-xia_sample"
      cloudwatch_db_log_group_name  = "openlxp_ecc-xia_sample-db"
      cloudwatch_db_application     = "openlxp_ecc-xia_sample-db"
      cluster_name                  = "openlxp-ecc_XIA_SAMPLECluster"
      ec2_instance_name             = "openlxp-ecc_XIA_SAMPLEContainerInstance"
      ec2_instance_type             = "t2.medium"
      ec2_volume_size               = "50"
      ec2_volume_type               = "gp2"
      xia_sample_image              = "openlxp/openlxp-xia-sample:latest"
      s3_key_name                   = "xia_sample.env"
      subnet1_name                  = "xia_sample_subnet1_useast1"
      subnet1_cidr_block            = "10.0.62.0/24"
      subnet2_name                  = "xia_sample_subnet2_useast1"
      subnet2_cidr_block            = "10.0.58.0/24"
      task_definition_name          = "openlxp-ecc_XIA_SAMPLETaskDefinition"
      work_dir                      = "/opt/app/openlxp-xia-sample"
    }
  }
}