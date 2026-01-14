# Amazon Elastic Container Registry (ECR) Repository
# This repository stores our production-grade Docker images.

resource "aws_ecr_repository" "app_repo" {
  name                 = "nextgen-devops-automation"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  encryption_configuration {
    encryption_type = "AES256"
  }

  tags = {
    Project     = "NextGen-DevOps-Automation"
    Environment = "Production"
    ManagedBy   = "Terraform"
  }
}

# Lifecycle policy to clean up old images and save costs
resource "aws_ecr_lifecycle_policy" "app_repo_policy" {
  repository = aws_ecr_repository.app_repo.name

  policy = <<EOF
{
    "rules": [
        {
            "rulePriority": 1,
            "description": "Keep last 10 images",
            "selection": {
                "tagStatus": "any",
                "countType": "imageCountMoreThan",
                "countNumber": 10
            },
            "action": {
                "type": "expire"
            }
        }
    ]
}
EOF
}
