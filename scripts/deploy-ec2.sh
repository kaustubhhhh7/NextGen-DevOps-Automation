#!/bin/bash

# NextGen DevOps - EC2 Deployment Script
# Deploys the project Docker container to a remote EC2 instance.

set -euo pipefail

# Configuration
EC2_HOST="${EC2_HOST:?Error: EC2_HOST environment variable is not set}"
EC2_USER="${EC2_USER:-ec2-user}"
SSH_KEY_PATH="${SSH_KEY_PATH:?Error: SSH_KEY_PATH environment variable is not set}"
IMAGE_NAME="nextgen-devops-automation"
TAG="latest"
CONTAINER_NAME="nextgen-devops"
TAR_FILE="nextgen-image.tar"

echo "🚀 Starting deployment to ${EC2_HOST}..."

# Navigate to project root
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR/.."

# 1. Build the image locally
echo "📦 Building Docker image..."
docker build -t "${IMAGE_NAME}:${TAG}" -f docker/Dockerfile .

# 2. Save image to tar
echo "💾 Saving image to tar file..."
docker save -o "${TAR_FILE}" "${IMAGE_NAME}:${TAG}"

# 3. Copy tar to EC2
echo "🚚 Copying image to EC2 via SCP..."
scp -i "${SSH_KEY_PATH}" -o StrictHostKeyChecking=no "${TAR_FILE}" "${EC2_USER}@${EC2_HOST}:~/"

# 4. Remote execution
echo "⚓ Loading image and starting container on EC2..."
ssh -i "${SSH_KEY_PATH}" -o StrictHostKeyChecking=no "${EC2_USER}@${EC2_HOST}" << EOF
  # Load the image
  docker load -i ~/${TAR_FILE}
  
  # Cleanup tar
  rm ~/${TAR_FILE}
  
  # Stop and remove existing container if it exists
  if docker ps -a | grep -q "${CONTAINER_NAME}"; then
    echo "Stopping existing container..."
    docker stop "${CONTAINER_NAME}"
    docker rm "${CONTAINER_NAME}"
  fi
  
  # Run new container
  echo "Starting new container..."
  docker run -d \
    --name "${CONTAINER_NAME}" \
    --restart unless-stopped \
    "${IMAGE_NAME}:${TAG}"
EOF

# 5. Local cleanup
rm "${TAR_FILE}"

echo "------------------------------------------------"
echo "DEPLOY SUCCESS: ${CONTAINER_NAME} running on EC2"
echo "------------------------------------------------"
