###############################################################
# IAM FOR OPENLXP_ECC
###############################################################
#####################################
# ECS TASKEXECUTION ROLE CREATION
#####################################
resource "aws_iam_role" "ecs_task_execution_role" {
  name = var.task_execution_role

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com",
        "Service": "s3.amazonaws.com",
        "Service": "secretsmanager.amazonaws.com",
        "Service": "ecs.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

  tags = {
    Name = var.task_execution_role
  }
}

#####################################
# POLICY FOR TASKEXECUTIONROLE
# FOR SECRETS RETRIEVAL
#####################################
resource "aws_iam_role_policy" "aws_secrets_policy" {
  name = var.aws_secrets_policy
  role = aws_iam_role.ecs_task_execution_role.id

  policy = <<-EOF
  {
    "Version": "2012-10-17",
    "Statement": [
        {
          "Effect": "Allow",
          "Action": [
              "secretsmanager:*",
              "kms:*",
              "ssm:*",
              "logs:*"
          ],
          "Resource": [
              "*"
          ]
        },
        {
          "Effect": "Allow",
          "Action": [
              "s3:GetObject"
          ],
          "Resource": [
              "arn:aws:s3:::${local.s3_bucket_name}/xds.env",
              "arn:aws:s3:::${local.s3_bucket_name}/xds_ui.env",
              "arn:aws:s3:::${local.s3_bucket_name}/xia_aetc.env",
              "arn:aws:s3:::${local.s3_bucket_name}/xia_dau.env",
              "arn:aws:s3:::${local.s3_bucket_name}/xia_edx.env",
              "arn:aws:s3:::${local.s3_bucket_name}/xia_jko.env",
              "arn:aws:s3:::${local.s3_bucket_name}/xia_moodle.env",
              "arn:aws:s3:::${local.s3_bucket_name}/xia_pebl.env",
              "arn:aws:s3:::${local.s3_bucket_name}/xis.env",
              "arn:aws:s3:::${local.s3_bucket_name}/xss.env",
              "arn:aws:s3:::${local.s3_bucket_name}/xms.env",
              "arn:aws:s3:::${local.s3_bucket_name}/xms_ui.env",
              "arn:aws:s3:::${local.s3_bucket_name}/xss.env",
              "arn:aws:s3:::${local.s3_bucket_name}/xia_sample.env"
          ]
        },
        {
          "Effect": "Allow",
          "Action": [
              "s3:GetBucketLocation"
          ],
          "Resource": [
              "arn:aws:s3:::${local.s3_bucket_name}"
          ]
        }
    ]
  }
EOF
}

######################################
# ATTACH AWS MANAGED POLICY TO ROLE
######################################
data "aws_iam_policy" "AmazonECSTaskExecutionRolePolicy" {
  arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_iam_policy_attachment" "AmazonECSTaskExecutionRolePolicyattach" {
  roles = [aws_iam_role.ecs_task_execution_role.name]
  policy_arn = data.aws_iam_policy.AmazonECSTaskExecutionRolePolicy.arn
  name = "AmazonECSTaskExecutionRolePolicy"
}

######################################
# CREATE ECS IAM ROLE POLICY
######################################
resource "aws_iam_role_policy" "ecs_iam_role_policy" {
  name = var.ecs_iam_role_policy
  role = aws_iam_role.ecs_role.id

  policy = <<-EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": [
          "ecs:Describe*",
          "secretsmanager:*",
          "kms:*",
          "ssm:*",
          "logs:*"
        ],
        "Effect": "Allow",
        "Resource": "*"
      }
    ]
  }
  EOF
}

######################################
# IAM ROLE FOR ECS CLUSTER
######################################
resource "aws_iam_role" "ecs_role" {
  name = var.ecs_role

  assume_role_policy = <<-EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": "sts:AssumeRole",
        "Principal": {
          "Service": "ecs.amazonaws.com",
          "Service": "ecs-tasks.amazonaws.com",
          "Service": "s3.amazonaws.com",
          "Service": "secretsmanager.amazonaws.com"
        },
        "Effect": "Allow",
        "Sid": ""
      }
    ]
  }
  EOF
}

data "aws_iam_policy_document" "ecs-instance-policy" {
   statement {
  actions = ["sts:AssumeRole"]
  principals {
  type = "Service"
  identifiers = ["ec2.amazonaws.com"]
  }
 }
}

######################################
# ROLE CREATION FOR ECS-EC2
######################################
resource "aws_iam_role" "ecs-instance-role" {
  name = "ecs-instance-role"
  path = "/"
  assume_role_policy = data.aws_iam_policy_document.ecs-instance-policy.json
}

resource "aws_iam_role_policy_attachment" "ecs-instance-role-attachment" {
   role = aws_iam_role.ecs-instance-role.name
   policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}

resource "aws_iam_instance_profile" "ecs-instance-profile" {
  name = "ecc-ecs-instance-profile"
  path = "/"
  role = aws_iam_role.ecs-instance-role.id
  provisioner "local-exec" {
  command = "sleep 60"
 }
}

resource "aws_iam_role" "ecs-service-role" {
  name = "ecs-service-role"
  path = "/"
  assume_role_policy = data.aws_iam_policy_document.ecs-service-policy.json
}

resource "aws_iam_role_policy_attachment" "ecs-service-role-attachment" {
  role = aws_iam_role.ecs-service-role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceRole"
}

data "aws_iam_policy_document" "ecs-service-policy" {
  statement {
    actions = [
      "sts:AssumeRole"]
    principals {
      type = "Service"
      identifiers = [
        "ecs.amazonaws.com"]
    }
  }
}



