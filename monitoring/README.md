# Monitoring Stack

This directory contains the local monitoring stack configuration using Prometheus and Grafana.

## Components

*   **Prometheus**: Time-series database and monitoring system.
*   **Grafana**: Visualization and analytics platform.

## Usage

1.  Navigate to the `monitoring` directory:
    ```bash
    cd monitoring
    ```

2.  Start the stack:
    ```bash
    docker-compose up -d
    ```

3.  Access the services:
    *   **Prometheus**: http://localhost:9090
    *   **Grafana**: http://localhost:3000 (Default login: `admin` / `admin`)

4.  Stop the stack:
    ```bash
    docker-compose down
    ```
