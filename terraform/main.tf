# NextGen DevOps Automation - Base Infrastructure Baseline

# Infrastructure baseline (VPC, ECR, or EKS) will be defined here.
# For now, we initialize an empty state to verify provider connectivity.

resource "aws_resourcegroups_group" "project_group" {
  name = "nextgen-devops-resources"

  resource_query {
    query = <<JSON
{
  "ResourceTypeFilters": ["AWS::AllSupported"],
  "TagFilters": [
    {
      "Key": "Project",
      "Values": ["NextGen-DevOps-Automation"]
    }
  ]
}
JSON
  }
}
