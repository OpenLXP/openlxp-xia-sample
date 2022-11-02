######################################################################
# CLUSTER CREATION FOR EXPERIENCE INDEX SERVICE (XIS)
######################################################################

resource "aws_ecs_cluster" "xis_ecs_cluster" {
  name                            = local.xis.cluster_name
}
#############################
# CREATES XIS ECS SERVICE
#############################
resource "aws_ecs_service" "xis_ecs_service" {
  name                            = aws_ecs_cluster.xis_ecs_cluster.name
  cluster                         = aws_ecs_cluster.xis_ecs_cluster.id
  task_definition                 = aws_ecs_task_definition.xis_task_definition.arn
  desired_count                   = 1
  launch_type                     = "EC2"
  scheduling_strategy             = "REPLICA"
}
