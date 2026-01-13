# Security Scanning Toolkit

This directory contains scripts and documentation for running local security scans on the NextGen DevOps Automation project.

## Local Trivy Scan

`trivy-scan.sh` is a utility script designed to build the project's Docker image and scan it for vulnerabilities using [Trivy](https://github.com/aquasecurity/trivy). This mirrors the security checks performed in the CI pipeline.

### Prerequisites

*   Docker installed and running.
*   Trivy installed (`brew install trivy` or similar).
*   Bash shell (Git Bash on Windows).

### Usage

1.  Navigate to the `security` directory:
    ```bash
    cd security
    ```
2.  Run the script:
    ```bash
    ./trivy-scan.sh
    ```

### Security Best Practices

*   **Least Privilege**: Ensure your local Docker user has only the permissions necessary.
*   **Secrets Management**: Never commit secrets or API keys to the repository. This script scans the *image*, but you should also be vigilant about what files are included in the build context.
*   **CI Parity**: While this script helps catch issues early, the CI pipeline is the ultimate gatekeeper for security compliance.
