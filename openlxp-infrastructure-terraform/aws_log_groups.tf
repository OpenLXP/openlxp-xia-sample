#############################################
# CLOUDWATCH LOGS CONFIGURATION FOR ECC
#############################################
############################
# XSS CLOUDWATCH LOGS
############################
resource "aws_cloudwatch_log_group" "openlxp_ecc-xss" {
  name = local.xss.cloudwatch_log_group_name

  tags = {
    Environment = var.environment
    Application = local.xss.cloudwatch_application
  }
}

resource "aws_cloudwatch_log_group" "openlxp_ecc-xss-db" {
  name = local.xss.cloudwatch_db_log_group_name

  tags = {
    Environment = var.environment
    Application = local.xss.cloudwatch_db_application
  }
}

############################
# XIS CLOUDWATCH LOGS
############################
resource "aws_cloudwatch_log_group" "openlxp_ecc-xis" {
  name = local.xis.cloudwatch_log_group_name

  tags = {
    Environment = var.environment
    Application = local.xis.cloudwatch_application
  }
}

resource "aws_cloudwatch_log_group" "openlxp_ecc-xis-db" {
  name = local.xis.cloudwatch_db_log_group_name

  tags = {
    Environment = var.environment
    Application = local.xis.cloudwatch_db_application
  }
}

############################
# XDS/XDS-UI CLOUDWATCH LOGS
############################
resource "aws_cloudwatch_log_group" "openlxp_ecc-xds" {
  name = local.xds.cloudwatch_log_group_name_xds

  tags = {
    Environment = var.environment
    Application = local.xds.cloudwatch_application_xds
  }
}

resource "aws_cloudwatch_log_group" "openlxp_ecc-xdsui" {
  name = local.xds.cloudwatch_log_group_name_ui

  tags = {
    Environment = var.environment
    Application = local.xds.cloudwatch_application_ui
  }
}

resource "aws_cloudwatch_log_group" "openlxp_ecc-xds-db" {
  name = local.xds.cloudwatch_db_log_group_name

  tags = {
    Environment = var.environment
    Application = local.xds.cloudwatch_db_application
  }
}

############################
# XMS/XMS-UI CLOUDWATCH LOGS
############################
resource "aws_cloudwatch_log_group" "openlxp_ecc-xms" {
  name = local.xms.cloudwatch_log_group_name_xms

  tags = {
    Environment = var.environment
    Application = local.xms.cloudwatch_application_xms
  }
}

resource "aws_cloudwatch_log_group" "openlxp_ecc-xmsui" {
  name = local.xms.cloudwatch_log_group_name_ui

  tags = {
    Environment = var.environment
    Application = local.xms.cloudwatch_application_ui
  }
}

resource "aws_cloudwatch_log_group" "openlxp_ecc-xms-db" {
  name = local.xms.cloudwatch_db_log_group_name

  tags = {
    Environment = var.environment
    Application = local.xms.cloudwatch_db_application
  }
}

//############################
//# XSE CLOUDWATCH LOGS
//############################
//resource "aws_cloudwatch_log_group" "openlxp_ecc-xse" {
//  name = local.xse.cloudwatch_log_group_name
//
//  tags = {
//    Environment = var.environment
//    Application = local.xse.cloudwatch_application
//  }
//}
//
//






