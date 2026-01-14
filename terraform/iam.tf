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
# Attachment of Managed Policy for ECR Read-Only Access
# This allows the instance to pull images from ECR without managing custom policy documents.
resource "aws_iam_role_policy_attachment" "ecr_read_only" {
  role       = aws_iam_role.compute_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

# Attachment of Managed Policy for CloudWatch Agent (Optional but recommended)
resource "aws_iam_role_policy_attachment" "cloudwatch_agent" {
  role       = aws_iam_role.compute_role.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}

# IAM Instance Profile for EC2 association
resource "aws_iam_instance_profile" "compute_profile" {
  name = "${var.environment}-compute-profile"
  role = aws_iam_role.compute_role.name
}
