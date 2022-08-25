################################################################
# AWS EXPERIENCE INDEX SERVICE (XIS) TASK DEFINITION
# DEFINED IN task_definitions/openlxp_xis.json
################################################################
resource "aws_ecs_task_definition" "xis_task_definition" {
  family                            = local.xis.task_definition_name
  container_definitions             = templatefile("${path.module}/task_definitions/openlxp_xis.json", {
                                        accountId  = data.aws_caller_identity.xis.account_id,
                                        region        = var.region,
                                        app_name      = local.xis.app_container_name,
                                        db_name       = local.xis.container_db_name,
                                        host_name     = local.xis.db_host_name,
                                        cw_group      = local.xis.cloudwatch_log_group_name,
                                        cw_db_group   = local.xis.cloudwatch_db_log_group_name,
                                        bucket_name   = local.s3_bucket_name,
                                        key_name      = local.xis.s3_key_name
                                      })
  network_mode                      = "bridge"
  requires_compatibilities          = ["EC2"]
  execution_role_arn                = "arn:aws:iam::${data.aws_caller_identity.xis.account_id}:role/${var.task_execution_role}"
  task_role_arn                     = "arn:aws:iam::${data.aws_caller_identity.xis.account_id}:role/${var.task_execution_role}"
  cpu                               = var.cpu
  memory                            = var.memory
}

##################################
# FOR RETRIEVING AWS ACCOUNT ID
##################################
data "aws_caller_identity" "xis" {}
