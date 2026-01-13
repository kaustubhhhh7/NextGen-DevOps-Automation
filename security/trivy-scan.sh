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

echo "[INFO] Build successful. Starting Trivy scan..."

# Run Trivy Scan
# --exit-code 1 triggers script failure if vulnerabilities are found
# --severity CRITICAL,HIGH filters for most dangerous issues
set +e # Temporarily disable immediate exit to capture exit code for custom message
trivy image --exit-code 1 --severity CRITICAL,HIGH --no-progress "${FULL_IMAGE_NAME}"
EXIT_CODE=$?
set -e # Re-enable strict mode

echo "=========================================="
if [ $EXIT_CODE -eq 0 ]; then
    echo "PASS: No HIGH/CRITICAL vulnerabilities found."
    exit 0
else
    echo "FAIL: HIGH/CRITICAL vulnerabilities detected."
    exit 1
fi
