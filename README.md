# DevOps Final Project - CI/CD Pipeline on AWS with Terraform, GitHub Actions, Docker, Trivy, EKS, and ArgoCD

## Architecture Diagram

<img width="1634" height="1055" alt="Final Project (V2)" src="https://github.com/user-attachments/assets/33334da2-e57a-45b1-90d8-e93afab6aa59" />

## 📘 Project Overview

This project demonstrates a complete DevOps CI/CD pipeline built on AWS Cloud using modern automation tools. It covers infrastructure provisioning, continuous integration, containerization, security scanning, Kubernetes deployment, and GitOps-driven continuous delivery.

---

## 🧱 Architecture Components

| Component | Description |
|------------|-------------|
| **Terraform** | Infrastructure as Code (IaC) tool used to provision all AWS resources including VPC, subnets, EC2 instances, EKS cluster, and S3 backend. |
| **AWS S3** | Stores the Terraform remote backend state file. |
| **AWS CloudWatch** | Monitors and logs events across the AWS environment. |
| **AWS SNS + Gmail** | Sends build/deployment notifications. |
| **GitHub Actions** | Automates CI/CD workflows for building, testing, and deploying code. |
| **Docker** | Builds application containers and pushes them to DockerHub. |
| **DockerHub** | Stores and manages the built Docker images, which are later pulled by Kubernetes for deployment. |
| **Trivy** | Scans Docker images for vulnerabilities before deployment. |
| **EKS (Elastic Kubernetes Service)** | Hosts and manages the containerized application using Kubernetes. |
| **ArgoCD** | Handles continuous deployment by monitoring GitHub for manifest changes. |
| **GitHub** | Central code repository for source code, Jenkinsfile, and Kubernetes manifests. |
| **Load Balancer** | Routes external user traffic to the Kubernetes worker nodes. |

---

## ⚙️ Workflow Overview

### 1️⃣ Infrastructure Provisioning
- The **DevOps Engineer** runs `terraform apply` to create AWS infrastructure:
  - VPC, subnets and EKS cluster.
  - Terraform state file stored in **S3** (remote backend).
  - Monitoring via **CloudWatch** and notifications via **SNS**.

### 2️⃣ CI - Continuous Integration (GitHub Actions)
- Trigger: Code push to GitHub repository
- Workflow:
  - Build Application - Compile and package
  - Build Docker Image - Create container image
  - Scan with Trivy - Security vulnerability check
  - Push to DockerHub - Store validated image
  - Update Manifests - Auto-update Kubernetes YAML with new image tag

### 3️⃣ CD - Continuous Deployment (Argo CD)
- ArgoCD updates Kubernetes manifest files with the new image tag.
- Updated manifests are pushed back to **GitHub**.
- **ArgoCD** detects changes and automatically syncs to the **EKS cluster**.
- Application is deployed and made accessible via the **Load Balancer**.

### 4️ Monitoring & Notifications
-  CloudWatch tracks pipeline events and performance
-  SNS sends email notifications to Gmail
-  Real-time alerts for build success/failure and deployments

---

## 🧩 Tools and Technologies

| Category | Tools |
|-----------|-------|
| Infrastructure | Terraform, AWS (VPC, EKS, S3, CloudWatch, SNS) |
| CI (Integration)| GitHub Actions |
| Containerization | Docker |
| Security | Trivy |
| CD (Deployment) | Kubernetes (EKS), ArgoCD |
| Monitoring | AWS CloudWatch |

---

## 🗂️ Repository Structure
```
├── Docker/
| ├── Dockerfile
| ├── architecture.html
| ├── assets/
│       └── favicon.ico
| ├── contact.html
| ├── css/
│       └── styles.css
| ├── index.html
| ├── js/
│       └── scripts.js
| └── tools.html
│
├── Terraform/
│ ├── main.tf
│ ├── variables.tf
│ ├── outputs.tf
│ └── backend.tf
│ ├── modules/
│ ├── vpc/
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
│ ├── cloudwatch/
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
│ └── eks/
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
│
├── github-workflows/
| └── ci.yaml
|
├── kubernetes/
│ ├── deployment.yaml
│ ├── service.yaml
│ └── namespace.yaml
│
├── ArgoCD/
| └── README.md
│
└── README.md
```

---

### 🔐 Security and Compliance

-  Image Scanning: All Docker images scanned with Trivy before deployment

-  Secure State Management: Terraform state encrypted in S3 with versioning

-  IAM Best Practices: Least privilege principles for AWS roles

-  Network Security: VPC with public subnets and NACL

-  Secrets Management: Kubernetes secrets and AWS Parameter Store

### 📊 Monitoring & Notifications

-  CloudWatch Alarms: Monitor EKS cluster metrics and pipeline events

-  SNS Topics: Send build/deployment notifications to Gmail

-  ArgoCD Dashboard: Visualize deployment status and sync state

-  GitHub Actions Logs: Real-time CI/CD pipeline monitoring
