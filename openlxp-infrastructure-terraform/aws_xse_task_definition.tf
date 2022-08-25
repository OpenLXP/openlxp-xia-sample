################################################################
# AWS EXPERIENCE SEARCH ENGINE (XSE) TASK DEFINITION
# DEFINED IN task_definitions/openlxp_xse.json
################################################################
resource "aws_ecs_task_definition" "xse_task_definition" {
  family                            = local.xse.task_definition_name
  container_definitions             = templatefile("${path.module}/task_definitions/openlxp_xse.json", {
                                        accountId      = data.aws_caller_identity.xse.account_id,
                                        region         = var.region,
                                        es1_name   = local.xse.es1_container_name,
                                        es2_name   = local.xse.es2_container_name,
                                        es3_name   = local.xse.es3_container_name,
                                        kib_name   = local.xse.kib_container_name
                                      })
  network_mode                      = "bridge"
  requires_compatibilities          = ["EC2"]
  execution_role_arn                = "arn:aws:iam::${data.aws_caller_identity.xse.account_id}:role/${var.task_execution_role}"
  task_role_arn                     = "arn:aws:iam::${data.aws_caller_identity.xse.account_id}:role/${var.task_execution_role}"
  cpu                               = var.cpu
  memory                            = var.memory
}

##################################
# FOR RETRIEVING AWS ACCOUNT ID
##################################
data "aws_caller_identity" "xse" {}
