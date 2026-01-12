# NextGen DevOps - IAM Governance (Identity & Access)

# IAM Role for Compute Resources (EC2 or Container Instances)
resource "aws_iam_role" "compute_role" {
  name = "${var.environment}-compute-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com" # Can be expanded to ecs-tasks.amazonaws.com later
        }
      },
    ]
  })

  tags = {
    Name = "${var.environment}-compute-role"
  }
}

# Least-Privilege Policy: Logging and ECR Read-Only
resource "aws_iam_policy" "compute_policy" {
  name        = "${var.environment}-compute-policy"
  description = "Least-privilege policy for logging and container registry access"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      # CloudWatch Logs Permission (Write-Only)
      {
        Effect = "Allow"
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents",
          "logs:DescribeLogStreams"
        ]
        Resource = "arn:aws:logs:*:*:*"
      },
      # ECR Read-Only Permissions (Future Container Pulls)
      {
        Effect = "Allow"
        Action = [
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage",
          "ecr:BatchCheckLayerAvailability",
          "ecr:GetAuthorizationToken"
        ]
        Resource = "*" # Resource level permission limited by actions
      }
    ]
  })
}

# Attachment of Policy to Role
resource "aws_iam_role_policy_attachment" "compute_attach" {
  role       = aws_iam_role.compute_role.name
  policy_arn = aws_iam_policy.compute_policy.arn
}

# IAM Instance Profile for EC2 association
resource "aws_iam_instance_profile" "compute_profile" {
  name = "${var.environment}-compute-profile"
  role = aws_iam_role.compute_role.name
}
