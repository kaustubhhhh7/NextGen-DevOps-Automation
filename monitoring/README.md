# Monitoring Stack

This directory contains the core monitoring infrastructure for the NextGen DevOps Automation project, utilizing the industry-standard Prometheus and Grafana stack.

## Components

- **Prometheus**: A cloud-native monitoring system that collects and stores metrics as time-series data.
- **Grafana**: A powerful visualization and analytics platform for querying and visualizing metrics.

## Getting Started

### Prerequisites

- [Docker](https://www.docker.com/get-started)
- [Docker Compose](https://docs.docker.com/compose/install/)

### Running the Stack

You can manage the stack using the provided scripts in the `scripts/` directory at the project root:

1.  **Start Monitoring**:
    ```bash
    ./scripts/start-monitoring.sh
    ```
2.  **Stop Monitoring**:
    ```bash
    ./scripts/stop-monitoring.sh
    ```

### Accessing Dashboards

Once running, the following services are available:

- **Prometheus UI**: [http://localhost:9090](http://localhost:9090)
- **Grafana UI**: [http://localhost:3000](http://localhost:3000)
  - *Default Credentials*: `admin` / `admin`

## Configuration

- `prometheus.yml`: Configures the scrape intervals and targets.
- `docker-compose.yml`: Defines the service orchestration, networking, and data persistence.
