# ArgoCD URL and Credentials Fix - Requirements Document

## Introduction

This specification addresses the issue where ArgoCD URL is not opening correctly with `argocd_hub_credentials` and instead redirects to a CloudFront URL. The goal is to ensure proper ArgoCD access configuration in the EKS fleet management workshop environment.

## Glossary

- **ArgoCD**: GitOps continuous delivery tool for Kubernetes
- **Hub Cluster**: The central EKS cluster that hosts ArgoCD for managing spoke clusters
- **CloudFront URL**: AWS CloudFront distribution URL that may be incorrectly configured
- **ArgoCD Hub Credentials**: Authentication credentials for accessing the ArgoCD instance on the hub cluster
- **Load Balancer**: AWS Application Load Balancer or Network Load Balancer exposing ArgoCD
- **Ingress Controller**: Kubernetes ingress controller managing external access to ArgoCD

## Requirements

### Requirement 1

**User Story:** As a workshop participant, I want to access ArgoCD using the provided hub credentials, so that I can manage GitOps deployments across the EKS fleet.

#### Acceptance Criteria

1. WHEN a user navigates to the ArgoCD URL THEN the system SHALL display the ArgoCD login interface
2. WHEN a user enters the hub credentials THEN the system SHALL authenticate successfully and display the ArgoCD dashboard
3. WHEN the ArgoCD service is accessed THEN the system SHALL use the correct load balancer endpoint instead of CloudFront URL
4. WHEN ArgoCD is deployed THEN the system SHALL configure proper ingress rules for external access
5. WHEN the load balancer is created THEN the system SHALL ensure it points to the correct ArgoCD service

### Requirement 2

**User Story:** As a system administrator, I want ArgoCD to be properly exposed through the correct networking configuration, so that users can access it reliably without URL redirection issues.

#### Acceptance Criteria

1. WHEN ArgoCD is deployed THEN the system SHALL create a dedicated load balancer for ArgoCD access
2. WHEN the ingress is configured THEN the system SHALL route traffic directly to ArgoCD pods without CloudFront interference
3. WHEN DNS resolution occurs THEN the system SHALL resolve to the load balancer endpoint not CloudFront
4. WHEN SSL/TLS is configured THEN the system SHALL use proper certificates for the ArgoCD domain
5. WHEN health checks are performed THEN the system SHALL verify ArgoCD service availability

### Requirement 3

**User Story:** As a workshop participant, I want clear documentation on how to access ArgoCD, so that I can troubleshoot access issues independently.

#### Acceptance Criteria

1. WHEN ArgoCD is deployed THEN the system SHALL output the correct ArgoCD URL in deployment logs
2. WHEN credentials are generated THEN the system SHALL provide clear instructions for accessing ArgoCD
3. WHEN troubleshooting is needed THEN the system SHALL include diagnostic commands for verifying ArgoCD status
4. WHEN the workshop is completed THEN the system SHALL provide validation steps to confirm ArgoCD accessibility
5. WHEN errors occur THEN the system SHALL log clear error messages indicating the root cause

### Requirement 4

**User Story:** As a developer, I want to verify that ArgoCD networking configuration is correct, so that I can ensure proper service exposure and avoid CloudFront URL conflicts.

#### Acceptance Criteria

1. WHEN ArgoCD service is created THEN the system SHALL verify the service type and port configuration
2. WHEN ingress resources are applied THEN the system SHALL validate ingress controller compatibility
3. WHEN load balancer is provisioned THEN the system SHALL confirm target group health and routing rules
4. WHEN DNS records are created THEN the system SHALL ensure they point to the load balancer not CloudFront
5. WHEN network policies exist THEN the system SHALL verify they allow proper ArgoCD traffic flow