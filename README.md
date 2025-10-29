# 🚀 DevOps Final Project — CI/CD Pipeline on AWS with Terraform, Jenkins, Docker, Trivy, EKS, Ansible, and ArgoCD

![Architecture Diagram](./Final%20Project.png)

## 📘 Project Overview

This project demonstrates a **complete DevOps CI/CD pipeline** built on **AWS Cloud** using modern automation tools.  
It covers infrastructure provisioning, continuous integration, containerization, image scanning, deployment to Kubernetes (EKS), and continuous delivery using ArgoCD.

---

## 🧱 Architecture Components

| Component | Description |
|------------|-------------|
| **Terraform** | Infrastructure as Code (IaC) tool used to provision all AWS resources including VPC, subnets, EC2 instances, EKS cluster, and S3 backend. |
| **AWS S3** | Stores the Terraform remote backend state file. |
| **AWS CloudWatch** | Monitors and logs events across the AWS environment. |
| **AWS SNS + Gmail** | Sends build/deployment notifications. |
| **Jenkins** | Automates CI/CD workflows for building, testing, and deploying code. |
| **Ansible** | Used to configure and set up Jenkins Master and Worker nodes. |
| **Docker** | Builds application containers and pushes them to DockerHub (or ECR). |
| **Trivy** | Scans Docker images for vulnerabilities before deployment. |
| **EKS (Elastic Kubernetes Service)** | Hosts and manages the containerized application using Kubernetes. |
| **ArgoCD** | Handles continuous deployment by monitoring GitHub for manifest changes. |
| **GitHub** | Central code repository for source code, Jenkinsfile, and Kubernetes manifests. |
| **Load Balancer** | Routes external user traffic to the Kubernetes worker nodes. |

---

## ⚙️ Workflow Overview

### 1️⃣ Infrastructure Provisioning
- The **DevOps Engineer** runs `terraform apply` to create AWS infrastructure:
  - VPC, subnets, EC2 instances, and EKS cluster.
  - Terraform state file stored in **S3** (remote backend).
  - Monitoring via **CloudWatch** and notifications via **SNS**.

### 2️⃣ Jenkins Setup
- Jenkins Master and Worker are provisioned on separate EC2 instances.
- **Ansible** playbooks configure Jenkins and its dependencies (Java, Git, Docker, Trivy).

### 3️⃣ CI — Continuous Integration
- Developer pushes code to **GitHub**.
- GitHub **webhook** triggers Jenkins.
- Jenkins pipeline executes:
  1. Build application.
  2. Build Docker image.
  3. Scan image using **Trivy**.
  4. Push scanned image to **DockerHub**.

### 4️⃣ CD — Continuous Deployment
- Jenkins updates Kubernetes manifest files with the new image tag.
- Updated manifests are pushed back to **GitHub**.
- **ArgoCD** detects changes and automatically syncs to the **EKS cluster**.
- Application is deployed and made accessible via the **Load Balancer**.

---

## 🧩 Tools and Technologies

| Category | Tools |
|-----------|-------|
| Infrastructure | Terraform, AWS (VPC, EC2, EKS, S3, CloudWatch, SNS) |
| Configuration Management | Ansible |
| CI/CD | Jenkins, GitHub Webhooks |
| Containerization | Docker |
| Security | Trivy |
| Deployment | Kubernetes (EKS), ArgoCD |
| Monitoring | AWS CloudWatch |

---

## 🗂️ Repository Structure

├── Terraform/
│ ├── main.tf
│ ├── variables.tf
│ ├── outputs.tf
│ └── backend.tf
│
├── Ansible/
│ ├── roles/
│ ├── playbooks/
│ └── inventory/
│
├── Jenkinsfile
│
├── kubernetes/
│ ├── deployment.yaml
│ ├── service.yaml
│ └── ingress.yaml
│
├── Dockerfile
│
├── scripts/
│ ├── build.sh
│ └── deploy.sh
│
├── Final Project.png
│
└── README.md


---

## 🚀 How to Run

### 1️⃣ Clone the Repository
```bash
git clone https://github.com/AhmedSabeh/final-devops-project.git
cd final-devops-project

2️⃣ Provision Infrastructure with Terraform
cd Terraform
terraform init
terraform apply -auto-approve

3️⃣ Configure Jenkins Servers using Ansible
cd Ansible
ansible-playbook -i inventory setup-jenkins.yml

4️⃣ Access Jenkins

Open Jenkins Master in your browser:
http://<jenkins-master-public-ip>:8080

5️⃣ Build and Deploy

Trigger Jenkins pipeline via GitHub webhook.

Watch Jenkins build logs.

Verify EKS deployment:

kubectl get pods -n <namespace>
kubectl get svc -n <namespace>

6️⃣ Access the Application

Get the Load Balancer DNS name:

kubectl get svc -n <namespace>


Visit in your browser:
http://<load-balancer-dns>

🔐 Security and Compliance

Docker images are scanned with Trivy before deployment.

Terraform backend is securely stored in S3 with proper IAM roles.

Jenkins credentials are encrypted and managed securely.

📧 Notifications

Amazon SNS integrates with Gmail to send build and deployment notifications.

🏁 Result

A fully automated CI/CD pipeline that:

Builds code automatically.

Scans and pushes Docker images.

Deploys to EKS.

Monitors and notifies on changes.
