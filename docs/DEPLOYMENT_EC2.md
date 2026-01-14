# EC2 Deployment Guide

This guide describes how to deploy the NextGen DevOps Automation project to an Amazon EC2 instance using the provided automation scripts.

## Prerequisites

1.  **EC2 Instance**: An active EC2 instance (Amazon Linux 2 or Ubuntu recommended).
2.  **Docker Installed**: Docker must be installed and running on the EC2 instance. The user must have permissions to run docker commands (e.g., in the `docker` group).
3.  **SSH Access**: You must have the SSH private key (`.pem`) and the instance must allow SSH traffic on port 22 from your IP.
4.  **Local Environment**: A Bash-compatible shell with `docker`, `ssh`, and `scp` installed.

## Environment Variables

The deployment scripts require the following environment variables:

| Variable | Description | Example |
| :--- | :--- | :--- |
| `EC2_HOST` | Public DNS or IP of the EC2 instance | `ec2-54-xx-xx-xx.compute-1.amazonaws.com` |
| `SSH_KEY_PATH` | Path to your SSH private key file | `~/.ssh/my-key.pem` |
| `EC2_USER` | (Optional) SSH user for the instance | `ec2-user` (default) or `ubuntu` |

## How to Deploy

1.  **Set your environment variables**:
    ```bash
    export EC2_HOST="your-ec2-ip"
    export SSH_KEY_PATH="/path/to/key.pem"
    ```

2.  **Run the deployment script**:
    ```bash
    ./scripts/deploy-ec2.sh
    ```
    This script will:
    - Build the Docker image locally.
    - Export it as a tarball.
    - Transfer the tarball to EC2.
    - Load the image on EC2 and restart the container.

## How to Rollback

If you need to stop the application on EC2:

```bash
./scripts/rollback-ec2.sh
```

## Troubleshooting

-   **Permission Denied (SSH)**: Ensure your `.pem` file has correct permissions (`chmod 400`) and the `EC2_USER` matches the OS (e.g., `ec2-user` for Amazon Linux, `ubuntu` for Ubuntu).
-   **Docker not running on EC2**: Ensure the Docker service is active: `sudo systemctl start docker`.
-   **Security Group Issues**: Verify the EC2 security group allows incoming traffic on port 22 (SSH) and any ports your application might expose.
-   **Image Load Failure**: Ensure there is enough disk space on the EC2 instance to store the image tarball and the loaded image.
