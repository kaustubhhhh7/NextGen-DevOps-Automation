#!/bin/bash

# NextGen DevOps - Start Monitoring Stack
# Uses bash strict mode for robustness
set -euo pipefail

echo "Starting NextGen DevOps Monitoring Stack..."

# Navigate to project root if script is run from scripts/ directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR/.."

# Launch the docker-compose stack
docker compose -f monitoring/docker-compose.yml up -d

echo "------------------------------------------------"
echo "Monitoring stack is UP and RUNNING"
echo "Prometheus URL: http://localhost:9090"
echo "Grafana URL:    http://localhost:3000 (admin/admin)"
echo "------------------------------------------------"
