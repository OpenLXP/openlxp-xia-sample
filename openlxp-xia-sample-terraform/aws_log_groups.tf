#############################################
# CLOUDWATCH LOGS CONFIGURATION FOR ECC
#############################################
############################
# XIA_SAMPLE CLOUDWATCH LOGS
############################
resource "aws_cloudwatch_log_group" "openlxp_ecc-xia-sample" {
  name = local.xia.sample.cloudwatch_log_group_name

  tags = {
    Environment = var.environment
    Application = local.xia.sample.cloudwatch_application
  }
}

resource "aws_cloudwatch_log_group" "openlxp_ecc-xia-sample-db" {
  name = local.xia.sample.cloudwatch_db_log_group_name

  tags = {
    Environment = var.environment
    Application = local.xia.sample.cloudwatch_db_application
  }
}





