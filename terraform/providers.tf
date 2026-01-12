terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  # Production Requirement: Remote State Management
  # Note: This is a placeholder for an S3/DynamoDB backend configuration
  # backend "s3" {
  #   bucket         = "nextgen-devops-terraform-state"
  #   key            = "state/terraform.tfstate"
  #   region         = "us-east-1"
  #   dynamodb_table = "terraform-lock"
  # }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project     = "NextGen-DevOps-Automation"
      Environment = var.environment
      ManagedBy   = "Terraform"
    }
  }
}
