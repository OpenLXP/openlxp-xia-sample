################################################################
# AWS EXPERIENCE SCHEMA SERVICE (XSS) TASK DEFINITION
# DEFINED IN task_definitions/openlxp_xss.json
################################################################
resource "aws_ecs_task_definition" "xss_task_definition" {
  family                            = local.xss.task_definition_name
  container_definitions             = templatefile("${path.module}/task_definitions/openlxp_xss.json", {
                                        accountId     = data.aws_caller_identity.xss.account_id,
                                        region        = var.region,
                                        app_name      = local.xss.app_container_name,
                                        db_name       = local.xss.container_db_name,
                                        host_name     = local.xss.db_host_name,
                                        bucket_name   = local.s3_bucket_name,
                                        key_name      = local.xss.s3_key_name
                                      })
  network_mode                      = "bridge"
  requires_compatibilities          = ["EC2"]
  execution_role_arn                = "arn:aws:iam::${data.aws_caller_identity.xss.account_id}:role/${var.task_execution_role}"
  task_role_arn                     = "arn:aws:iam::${data.aws_caller_identity.xss.account_id}:role/${var.task_execution_role}"
  cpu                               = var.cpu
  memory                            = var.memory
}

##################################
# FOR RETRIEVING AWS ACCOUNT ID
##################################
data "aws_caller_identity" "xss" {}