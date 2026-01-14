#!/bin/bash

# NextGen DevOps - Deploy from ECR to EC2
# Pulls the latest Docker image from ECR and deploys it to a remote EC2 instance.

set -euo pipefail

# Configuration Checks
EC2_HOST="${EC2_HOST:?Error: EC2_HOST environment variable is not set}"
EC2_USER="${EC2_USER:-ec2-user}"
SSH_KEY_PATH="${SSH_KEY_PATH:?Error: SSH_KEY_PATH environment variable is not set}"
AWS_REGION="${AWS_REGION:?Error: AWS_REGION environment variable is not set}"
ECR_REPO_URL="${ECR_REPO_URL:?Error: ECR_REPO_URL environment variable is not set}"

CONTAINER_NAME="nextgen-devops"

echo "🚀 Starting ECR deployment to ${EC2_HOST}..."

# Extract Registry URL (domain) from Repo URL (e.g. 123.dkr.ecr.us-east-1.amazonaws.com)
# We assume the URL format is valid.
ECR_REGISTRY=$(echo "$ECR_REPO_URL" | cut -d'/' -f1)

# Remote Execution
ssh -i "${SSH_KEY_PATH}" -o StrictHostKeyChecking=no "${EC2_USER}@${EC2_HOST}" << EOF
  set -e
  
  echo "🔑 Logging into ECR ($ECR_REGISTRY)..."
  # Login to ECR on the EC2 instance
  aws ecr get-login-password --region "${AWS_REGION}" | docker login --username AWS --password-stdin "${ECR_REGISTRY}"

  echo "⬇️  Pulling latest image..."
  docker pull "${ECR_REPO_URL}:latest"

  # Stop and remove existing container if it exists
  if docker ps -a --format '{{.Names}}' | grep -q "^${CONTAINER_NAME}$"; then
    echo "🛑 Stopping existing container..."
    docker stop "${CONTAINER_NAME}"
    docker rm "${CONTAINER_NAME}"
  fi

  echo "▶️  Starting new container..."
  docker run -d \
    --name "${CONTAINER_NAME}" \
    --restart unless-stopped \
    "${ECR_REPO_URL}:latest"

EOF

echo "------------------------------------------------"
echo "DEPLOY SUCCESS: Pulled from ECR and started ${CONTAINER_NAME} on EC2"
echo "------------------------------------------------"
