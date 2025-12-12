# Force delete the secretaws secretsmanager 
aws secretsmanager delete-secret --secret-id "eks-fleet-workshop-gitops-workloads" --force-delete-without-recovery  
aws secretsmanager delete-secret --secret-id "eks-fleet-workshop-gitops-platform" --force-delete-without-recovery
aws secretsmanager delete-secret --secret-id "eks-fleet-workshop-gitops-addons" --force-delete-without-recovery
aws secretsmanager delete-secret --secret-id "eks-fleet-workshop-gitops-fleet" --force-delete-without-recovery
aws secretsmanager delete-secret --secret-id "fleet-hub-cluster/fleet-spoke-staging" --force-delete-without-recovery
aws secretsmanager delete-secret --secret-id "fleet-hub-cluster/fleet-spoke-prod" --force-delete-without-recovery





# Delete specific SSM parameters by name
aws ssm delete-parameter --name "eks-fleet-workshop-gitops-argocd-central-role"
aws ssm delete-parameter --name "eks-fleet-workshop-gitops-backend-team-view-role" 
aws ssm delete-parameter --name "eks-fleet-workshop-gitops-frontend-team-view-role"
aws ssm delete-parameter --name "eks-fleet-workshop-gitops-amp-hub-arn"
aws ssm delete-parameter --name "eks-fleet-workshop-gitops-amp-hub-endpoint"


# List and delete all eks-fleet-workshop SSM parameters
aws ssm get-parameters-by-path --path "/aws/service" --query 'Parameters[?contains(Name, `eks-fleet-workshop`)].Name' --output text | xargs -I {} aws ssm delete-parameter --name {}

# Alternative: Delete by name pattern
for param in $(aws ssm describe-parameters --query 'Parameters[?contains(Name, `eks-fleet-workshop`)].Name' --output text); do
    aws ssm delete-parameter --name "$param"
done
