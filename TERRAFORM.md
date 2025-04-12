# 📘 Terraform Cloud Infrastructure for Art Gallery Project

## 📁 Project Structure
```bash
terraform/
├── main.tf                # Module composition and backend definition
├── variables.tf           # Global input variables
├── outputs.tf             # Global output values
├── security_group.tf      # AWS security_group
├── versions.tf            # Terraform and provider version
├── .gitignore             # Ignore local or sensitive files
│
├── modules/
│   ├── vpc/               # VPC, subnets, NAT gateway
│   ├── alb/               # Application Load Balancer
│   ├── ecr/               # ECR repositories
│   ├── iam/               # IAM roles and policies
│   ├── ecs/               # ECS cluster and Cloud Map
│   │   └── services/      # ECS services (frontend, backend-rds, backend-redis)
│   ├── rds/               # PostgreSQL RDS instance
│   └── cloudwatch/        # Monitoring and log group setup
```

---

## ☁️ Terraform Cloud Setup
The project is managed using **Terraform Cloud**:
- Remote backend for `.tfstate` file
- GitHub integration for auto-triggered runs
- Secure OIDC-based authentication to AWS

### ✅ Backend Config (in `versions.tf`)
```hcl
terraform {
  required_version = ">= 1.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "art-gallery-devops"

    workspaces {
      name = "art-gallery"
    }
  }
}
```

---

## 🔐 AWS OIDC Integration (Terraform Cloud ↔ AWS)
**IAM role** with trust policy to allow Terraform Cloud to assume it:
```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "arn:aws:iam::<ACCOUNT_ID>:oidc-provider/app.terraform.io"
      },
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Condition": {
        "StringEquals": {
          "app.terraform.io:aud": "terraform"
        },
        "StringLike": {
          "app.terraform.io:sub": "organization:art-gallery-devops:project:*:workspace:art-gallery:run_phase:*"
        }
      }
    }
  ]
}
```

---

### 🗺 Full Infra Workflow Diagram

```mermaid
graph TD
  A[Dev: VS Code / Local] --> B[GitHub push]
  B --> C[Terraform Cloud workspace]
  C --> D[terraform plan and apply (remote)]
  D --> E[OIDC IAM Role]
  E --> F[AWS infrastructure (VPC, ECS, RDS, etc)]

---

## 📜 Manual Deployment Flow
1. Push changes to GitHub
2. Terraform Cloud detects changes and starts plan
3. Run UI prompts for `Confirm & Apply`
4. Terraform Cloud uses OIDC IAM Role to apply to AWS

---

## ⚙️ Additional Config
### .gitignore
```gitignore
.terraform/
*.tfstate
*.tfstate.backup
.terraform.lock.hcl
terraform.tfvars
```

### Optional Local Commands (if needed):
```bash
terraform fmt        # Format your code
terraform validate   # Validate configuration
terraform plan       # Dry-run plan
terraform apply      # Apply manually (if not using auto-apply)
```

---

