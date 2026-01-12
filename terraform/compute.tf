# NextGen DevOps - Compute Layer (Validation Instance)

# Data Source: Fetch Latest Amazon Linux 2 AMI
data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# EC2 Instance in Public Subnet for Infrastructure Validation
resource "aws_instance" "web_server" {
  ami           = data.aws_ami.amazon_linux_2.id
  instance_type = var.instance_type
  key_name      = var.key_name

  # Network & Security
  subnet_id                   = aws_subnet.public.id
  vpc_security_group_ids      = [aws_security_group.public_sg.id]
  iam_instance_profile        = aws_iam_instance_profile.compute_profile.name
  associate_public_ip_address = true

  # Bootstrap Script: Docker Installation
  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              amazon-linux-extras install docker -y
              service docker start
              systemctl enable docker
              usermod -a -G docker ec2-user
              echo "NextGen DevOps Automation: Infrastructure Validation Complete. Docker installed." > /var/log/bootstrap.log
              EOF

  tags = {
    Name = "${var.environment}-validation-instance"
  }

  # Lifecycle rule to prevent accidental destruction if needed
  lifecycle {
    create_before_destroy = true
  }
}
