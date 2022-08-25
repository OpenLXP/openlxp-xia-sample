######################################################################
# CLUSTER CREATION FOR EXPERIENCE INDEX AGENT (XIA SAMPLE)
######################################################################
resource "aws_ecs_cluster" "xia_sample_ecs_cluster" {
  name                            = local.xia.sample.cluster_name
}
##################################
# CREATES XIA SAMPLE ECS SERVICE
##################################
resource "aws_ecs_service" "xia_sample_ecs_service" {
  name                            = aws_ecs_cluster.xia_sample_ecs_cluster.name
  cluster                         = aws_ecs_cluster.xia_sample_ecs_cluster.id
  task_definition                 = aws_ecs_task_definition.xia_sample_task_definition.arn
  desired_count                   = 1
  launch_type                     = "EC2"
  scheduling_strategy             = "REPLICA"
}
