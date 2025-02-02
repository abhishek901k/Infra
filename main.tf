provider "aws" {
  region = "ap-south-1"
}

resource "aws_iam_openid_connect_provider" "github_oidc_provider" {
  url = "https://token.actions.githubusercontent.com"
  client_id_list = [
    "sts.amazonaws.com",
  ]
  thumbprint_list = [
    "5b6df07c2b8a3d6bcd1f39a7f55d9a8aef0ccf1c"
  ]
}

resource "aws_iam_role" "github_oidc_role" {
  name = "github_oidc_role_for_ecr_ecs"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRoleWithWebIdentity"
        Effect = "Allow"
        Principal = {
          Federated = aws_iam_openid_connect_provider.github_oidc_provider.arn
        }
        Condition = {
          StringEquals = {
            "token.actions.githubusercontent.com:sub" = [
              "repo:abhishek901k/Infra:ref:refs/heads/main",
              "repo:abhishek901k/MusicApp:ref:refs/heads/main"
            ]
          }
        }
      }
    ]
  })
}

resource "aws_iam_policy" "ecr_ecs_policy" {
  name        = "ecr_ecs_policy"
  description = "Policy allowing actions on ECR and ECS"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ecr:GetAuthorizationToken",
          "ecr:BatchCheckLayerAvailability",
          "ecr:GetRepositoryPolicy",
          "ecr:ListImages",
          "ecr:DescribeRepositories",
          "ecr:CreateRepository",
          "ecr:PutImage"
        ]
        Effect   = "Allow"
        Resource = "*"
      },
      {
        Action = [
          "ecs:RunTask",
          "ecs:DescribeTasks",
          "ecs:ListClusters",
          "ecs:CreateCluster",
          "ecs:UpdateService",
          "ecs:DescribeServices",
          "ecs:ListServices",
          "ecs:CreateService"
        ]
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "attach_ecr_ecs_policy" {
  policy_arn = aws_iam_policy.ecr_ecs_policy.arn
  role       = aws_iam_role.github_oidc_role.name
}
