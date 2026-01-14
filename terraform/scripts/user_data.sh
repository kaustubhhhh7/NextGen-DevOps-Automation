#!/bin/bash
set -e

# Update system
yum update -y

# Install Docker
amazon-linux-extras install docker -y
service docker start
systemctl enable docker

# Add ecosystem user to docker group
usermod -a -G docker ec2-user

# Log completion
echo "NextGen DevOps Automation: Infrastructure Validation Complete. Docker installed." > /var/log/bootstrap.log
