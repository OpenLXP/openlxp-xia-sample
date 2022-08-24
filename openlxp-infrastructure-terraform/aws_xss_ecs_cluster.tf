######################################################################
# CLUSTER CREATION FOR EXPERIENCE SCHEMA SERVICE (XSS)
######################################################################
resource "aws_ecs_cluster" "xss_ecs_cluster" {
  name                            = local.xss.cluster_name
}
###########################
# CREATES XSS ECS SERVICE
###########################
resource "aws_ecs_service" "xss_ecs_service" {
  name                            = aws_ecs_cluster.xss_ecs_cluster.name
  cluster                         = aws_ecs_cluster.xss_ecs_cluster.id
  task_definition                 = aws_ecs_task_definition.xss_task_definition.arn
  desired_count                   = 1
  launch_type                     = "EC2"
  scheduling_strategy             = "REPLICA"
}
