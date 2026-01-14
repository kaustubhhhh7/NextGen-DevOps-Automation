# ECR Setup & CI/CD Configuration

This guide explains how to configure AWS and GitHub to enable automated Docker image pushes to Amazon Elastic Container Registry (ECR).

## AWS Credentials Configuration

To allow GitHub Actions to push images to ECR, you need to create an IAM user with appropriate permissions.

1.  **Create IAM User**: In the AWS Console, create a new user (e.g., `github-actions-pusher`).
2.  **Attach Policy**: Attach a policy that allows ECR access. `AmazonEC2ContainerRegistryPowerUser` is generally sufficient.
3.  **Generate Access Keys**: Create an "Access Key ID" and "Secret Access Key" for this user.

## GitHub Secrets Configuration

Add the following secrets to your GitHub repository under **Settings > Secrets and variables > Actions**:

| Secret Name | Value |
| :--- | :--- |
| `AWS_ACCESS_KEY_ID` | Your IAM user's Access Key ID |
| `AWS_SECRET_ACCESS_KEY` | Your IAM user's Secret Access Key |
| `AWS_REGION` | The AWS region where ECR is hosted (e.g., `us-east-1`) |

## Confirming Image Push

Every time code is pushed to the `main` branch:
1.  The CI pipeline will trigger.
2.  The `Build & Push to ECR` job will run after successful Terraform checks and initial Docker builds.
3.  Verify the image in the [AWS ECR Console](https://console.aws.amazon.com/ecr/repositories).

## Common Errors & Fixes

-   **`AccessDeniedException`**: Ensure the IAM user has the `ecr:GetAuthorizationToken` permission (included in PowerUser).
-   **`RepositoryNotFoundException`**: Check that the `ECR_REPOSITORY` name in `ci.yml` matches exactly with the name in `terraform/ecr.tf`.
-   **`ExpiredToken`**: AWS credentials provided in secrets may have expired or been deactivated.
