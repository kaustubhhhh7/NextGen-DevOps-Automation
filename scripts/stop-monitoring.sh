#!/bin/bash

# NextGen DevOps - Stop Monitoring Stack
# Uses bash strict mode for robustness
set -euo pipefail

echo "Stopping NextGen DevOps Monitoring Stack..."

# Navigate to project root if script is run from scripts/ directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR/.."

# Shutdown the docker-compose stack
docker compose -f monitoring/docker-compose.yml down

echo "Monitoring stack stopped."
echo "------------------------------------------------"
