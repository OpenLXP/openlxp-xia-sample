######################################################################
# CLUSTER CREATION FOR EXPERIENCE SEARCH ENGINE (XSE)
######################################################################

resource "aws_ecs_cluster" "xse_ecs_cluster" {
  name                            = local.xse.cluster_name
}
#############################
# CREATES XSE ECS SERVICE
#############################
resource "aws_ecs_service" "xse_ecs_service" {
  name                            = aws_ecs_cluster.xse_ecs_cluster.name
  cluster                         = aws_ecs_cluster.xse_ecs_cluster.id
  task_definition                 = aws_ecs_task_definition.xse_task_definition.arn
  desired_count                   = 1
  launch_type                     = "EC2"
  scheduling_strategy             = "REPLICA"
}
