#!/bin/bash
set -euo pipefail

# Configuration
IMAGE_NAME="nextgen-devops-automation"
IMAGE_TAG="local"
FULL_IMAGE_NAME="${IMAGE_NAME}:${IMAGE_TAG}"

echo "=========================================="
echo "  NextGen DevOps Security Scanner"
echo "=========================================="

echo "[INFO] Building Docker image: ${FULL_IMAGE_NAME}..."
# Build from the parent directory to capture correct context
docker build -t "${FULL_IMAGE_NAME}" -f ../docker/Dockerfile ../

echo "[INFO] Build successful."
