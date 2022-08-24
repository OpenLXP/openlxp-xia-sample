######################################################################
# CLUSTER CREATION FOR:
# EXPERIENCE MANAGEMENT SERVICE (XMS)
# EXPERIENCE MANAGEMENT SERVICE UI (XMS-UI)
######################################################################
resource "aws_ecs_cluster" "xms_ecs_cluster" {
  name                            = local.xms.cluster_name
}
#############################
# CREATES XMS ECS SERVICE
#############################
resource "aws_ecs_service" "xms_ecs_service" {
  name                            = aws_ecs_cluster.xms_ecs_cluster.name
  cluster                         = aws_ecs_cluster.xms_ecs_cluster.id
  task_definition                 = aws_ecs_task_definition.xms_task_definition.arn
  desired_count                   = 1
  launch_type                     = "EC2"
  scheduling_strategy             = "REPLICA"
}
