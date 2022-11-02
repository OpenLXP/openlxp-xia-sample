################################################################
# AWS EXPERIENCE INDEX AGENT (XIA SAMPLE) TASK DEFINITION
# DEFINED IN task_definitions/openlxp_xia_sample.json
################################################################
resource "aws_ecs_task_definition" "xia_sample_task_definition" {
  family                            = local.xia.sample.task_definition_name
  container_definitions             = templatefile("${path.module}/task_definitions/openlxp_xia_sample.json", {
                                        accountId         = data.aws_caller_identity.xia_sample.account_id,
                                        region            = var.region,
                                        app_name          = local.xia.sample.app_container_name,
                                        db_name           = local.xia.sample.container_db_name,
                                        cw_group          = local.xia.sample.cloudwatch_log_group_name,
                                        cw_db_group       = local.xia.sample.cloudwatch_db_log_group_name,
                                        bucket_name       = local.s3_bucket_name,
                                        key_name          = local.xia.sample.s3_key_name
                                        work_dir          = local.xia.sample.work_dir
                                        xia_sample_image  = local.xia.sample.xia_sample_image
                                      })
  network_mode                      = "bridge"
  requires_compatibilities          = ["EC2"]
  execution_role_arn                = "arn:aws:iam::${data.aws_caller_identity.xia_sample.account_id}:role/${var.task_execution_role}"
  task_role_arn                     = "arn:aws:iam::${data.aws_caller_identity.xia_sample.account_id}:role/${var.task_execution_role}"
  cpu                               = var.cpu
  memory                            = var.memory
}

##################################
# FOR RETRIEVING AWS ACCOUNT ID
##################################
data "aws_caller_identity" "xia_sample" {}