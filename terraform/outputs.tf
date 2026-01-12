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
