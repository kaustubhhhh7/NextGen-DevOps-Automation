# NextGen DevOps - Infrastructure Outputs

output "instance_id" {
  description = "The ID of the validation EC2 instance"
  value       = aws_instance.web_server.id
}

output "public_ip" {
  description = "The public IP address of the validation EC2 instance"
  value       = aws_instance.web_server.public_ip
}

output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.main.id
}

output "ecr_repository_url" {
  description = "The URL of the ECR repository"
  value       = aws_ecr_repository.app_repo.repository_url
}
