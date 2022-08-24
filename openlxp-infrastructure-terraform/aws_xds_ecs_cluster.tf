######################################################################
# CLUSTER CREATION FOR:
# EXPERIENCE DISCOVERY SERVICE (XDS)
# EXPERIENCE DISCOVERY SERVICE UI (XDS/XDSUI)
######################################################################
resource "aws_ecs_cluster" "xds_ecs_cluster" {
  name                            = local.xds.cluster_name
}
#############################
# CREATES XIS ECS SERVICE
#############################
resource "aws_ecs_service" "xds_ecs_service" {
  name                            = aws_ecs_cluster.xds_ecs_cluster.name
  cluster                         = aws_ecs_cluster.xds_ecs_cluster.id
  task_definition                 = aws_ecs_task_definition.xds_task_definition.arn
  desired_count                   = 1
  launch_type                     = "EC2"
  scheduling_strategy             = "REPLICA"
}
