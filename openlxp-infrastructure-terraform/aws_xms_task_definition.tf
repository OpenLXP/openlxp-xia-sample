################################################################
# AWS TASK DEFINITION FOR:
# EXPERIENCE MANAGEMENT SERVICE (XMS)
# EXPERIENCE MANAGEMENT SERVICE UI (XMS-UI)
# DEFINED IN task_definitions/openlxp_xms.json
################################################################
resource "aws_ecs_task_definition" "xms_task_definition" {
  family                            = local.xms.task_definition_name
  container_definitions             = templatefile("${path.module}/task_definitions/openlxp_xms.json", {
                                        accountId   = data.aws_caller_identity.xms.account_id,
                                        region      = var.region,
                                        app_name    = local.xms.app_container_name_xms,
                                        db_name     = local.xms.container_db_name,
                                        app_name_ui = local.xms.container_name_xms-ui,
                                        bucket_name     = local.s3_bucket_name,
                                        xms_key_name    = local.xms.s3_xms_key_name,
                                        xmsui_key_name  = local.xms.s3_xmsui_key_name
                                      })
  network_mode                      = "bridge"
  requires_compatibilities          = ["EC2"]
  execution_role_arn                = "arn:aws:iam::${data.aws_caller_identity.xms.account_id}:role/${var.task_execution_role}"
  task_role_arn                     = "arn:aws:iam::${data.aws_caller_identity.xms.account_id}:role/${var.task_execution_role}"
  cpu                               = var.cpu
  memory                            = var.memory
}

##################################
# FOR RETRIEVING AWS ACCOUNT ID
##################################
data "aws_caller_identity" "xms" {}