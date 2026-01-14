#!/bin/bash

# NextGen DevOps - EC2 Rollback Script
# Stops and removes the deployment on the remote EC2 instance.

set -euo pipefail

# Configuration
EC2_HOST="${EC2_HOST:?Error: EC2_HOST environment variable is not set}"
EC2_USER="${EC2_USER:-ec2-user}"
SSH_KEY_PATH="${SSH_KEY_PATH:?Error: SSH_KEY_PATH environment variable is not set}"
CONTAINER_NAME="nextgen-devops"

echo "🛑 Starting rollback on ${EC2_HOST}..."

ssh -i "${SSH_KEY_PATH}" -o StrictHostKeyChecking=no "${EC2_USER}@${EC2_HOST}" << EOF
  if docker ps -a | grep -q "${CONTAINER_NAME}"; then
    echo "Stopping and removing container: ${CONTAINER_NAME}..."
    docker stop "${CONTAINER_NAME}"
    docker rm "${CONTAINER_NAME}"
  else
    echo "No container named ${CONTAINER_NAME} found."
  fi
EOF

echo "------------------------------------------------"
echo "ROLLBACK DONE: ${CONTAINER_NAME} stopped on EC2"
echo "------------------------------------------------"
