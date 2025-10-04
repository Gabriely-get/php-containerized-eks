## Provider com LocalStack para emular cloud em ambiente da própria Action
provider "aws" {
            
    access_key                  = "mock_access_key"
    secret_key                  = "mock_secret_key"
    region                      = "us-east-1"

    s3_use_path_style           = true
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    skip_requesting_account_id  = true

    endpoints {
        apigateway     = "http://localhost:4566"
        apigatewayv2   = "http://localhost:4566"
        cloudformation = "http://localhost:4566"
        cloudwatch     = "http://localhost:4566"
        cloudwatchlogs = "http://localhost:4566"
        dynamodb       = "http://localhost:4566"
        ec2            = "http://localhost:4566"
        es             = "http://localhost:4566"
        eks            = "http://localhost:4566"
        elasticache    = "http://localhost:4566"
        firehose       = "http://localhost:4566"
        iam            = "http://localhost:4566"
        kinesis        = "http://localhost:4566"
        lambda         = "http://localhost:4566"
        rds            = "http://localhost:4566"
        redshift       = "http://localhost:4566"
        route53        = "http://localhost:4566"
        s3             = "http://localhost:4566"
        secretsmanager = "http://localhost:4566"
        ses            = "http://localhost:4566"
        sns            = "http://localhost:4566"
        sqs            = "http://localhost:4566"
        ssm            = "http://localhost:4566"
        stepfunctions  = "http://localhost:4566"
        sts            = "http://localhost:4566"
    }
}

## Criar infra básica: VPC, subnet privada
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr_block

  tags = {
    Name = "EKS-VPC"
  }
}

resource "aws_subnet" "az1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.subnet_cidr_block
  availability_zone       = var.availability_zone
  map_public_ip_on_launch = false

  tags = {
    Name = "private-subnet-${var.availability_zone}"
  }
}


## Definição de cluster a partir do site oficial TF Registry: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_cluster#example-usage
resource "aws_eks_cluster" "php" {
  name = "php-cluster"

#   access_config {
#     authentication_mode = "API"
#   }

  role_arn = aws_iam_role.cluster.arn
  version  = "1.31"

  vpc_config {
    subnet_ids = [
      aws_subnet.az1.id
    ]
  }

  depends_on = [
    aws_iam_role_policy_attachment.cluster_AmazonEKSClusterPolicy,
  ]
}

resource "aws_iam_role" "cluster" {
  name = "eks-cluster-example"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "sts:AssumeRole",
          "sts:TagSession"
        ]
        Effect = "Allow"
        Principal = {
          Service = "eks.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "cluster_AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.cluster.name
}