################################################################
# AWS TASK DEFINITION FOR:
# EXPERIENCE DISCOVERY SERVICE (XDS)
# EXPERIENCE DISCOVERY SERVICE UI (XDS-UI)
# DEFINED IN task_definitions/openlxp_xds.json
################################################################
resource "aws_ecs_task_definition" "xds_task_definition" {
  family                            = local.xds.task_definition_name
  container_definitions             = templatefile("${path.module}/task_definitions/openlxp_xds.json", {
                                        accountId       = data.aws_caller_identity.xds.account_id,
                                        region          = var.region,
                                        app_name        = local.xds.app_container_name_xds,
                                        db_name         = local.xds.container_db_name,
                                        app_name_ui     = local.xds.container_name_xds-ui,
                                        bucket_name     = local.s3_bucket_name,
                                        cw_group_ui     = local.xds.cloudwatch_log_group_name_ui,
                                        cw_group        = local.xds.cloudwatch_log_group_name_xds,
                                        cw_db_group     = local.xds.cloudwatch_db_log_group_name,
                                        xds_key_name    = local.xds.s3_xds_key_name,
                                        xdsui_key_name  = local.xds.s3_xdsui_key_name
                                      })
  network_mode                      = "bridge"
  requires_compatibilities          = ["EC2"]
  execution_role_arn                = "arn:aws:iam::${data.aws_caller_identity.xds.account_id}:role/${var.task_execution_role}"
  task_role_arn                     = "arn:aws:iam::${data.aws_caller_identity.xds.account_id}:role/${var.task_execution_role}"
  cpu                               = var.cpu
  memory                            = var.memory
}

##################################
# FOR RETRIEVING AWS ACCOUNT ID
##################################
data "aws_caller_identity" "xds" {}