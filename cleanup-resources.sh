#!/bin/bash

echo "Cleaning up existing EKS Fleet Workshop resources..."

# Delete Secrets Manager secrets
echo "Deleting Secrets Manager secrets..."
aws secretsmanager delete-secret --secret-id "eks-fleet-workshop-gitops-fleet" --force-delete-without-recovery || true
aws secretsmanager delete-secret --secret-id "eks-fleet-workshop-gitops-workloads" --force-delete-without-recovery || true
aws secretsmanager delete-secret --secret-id "eks-fleet-workshop-gitops-platform" --force-delete-without-recovery || true
aws secretsmanager delete-secret --secret-id "eks-fleet-workshop-gitops-addons" --force-delete-without-recovery || true

# Delete SSM parameters
echo "Deleting SSM parameters..."
aws ssm delete-parameter --name "eks-fleet-workshop-gitops-argocd-central-role" || true
aws ssm delete-parameter --name "eks-fleet-workshop-gitops-backend-team-view-role" || true
aws ssm delete-parameter --name "eks-fleet-workshop-gitops-frontend-team-view-role" || true
aws ssm delete-parameter --name "eks-fleet-workshop-gitops-amp-hub-arn" || true
aws ssm delete-parameter --name "eks-fleet-workshop-gitops-amp-hub-endpoint" || true

# Delete AMP workspace (if exists)
echo "Checking for AMP workspaces..."
AMP_WORKSPACES=$(aws amp list-workspaces --query 'workspaces[?contains(alias, `eks-fleet-workshop`)].workspaceId' --output text)
for workspace in $AMP_WORKSPACES; do
    echo "Deleting AMP workspace: $workspace"
    aws amp delete-workspace --workspace-id "$workspace" || true
done

echo "Cleanup complete! You can now redeploy the CloudFormation template."