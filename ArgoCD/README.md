# 🚀 ArgoCD — GitOps Continuous Deployment

This section documents the ArgoCD setup and deployment process used in the DEPI Final DevOps Project for automating Kubernetes deployments.

## 🧩 Overview

ArgoCD is a GitOps continuous delivery tool that automatically synchronizes and deploys Kubernetes manifests from this GitHub repository to the EKS cluster.

Goal:
Whenever new code or configuration is pushed to GitHub, ArgoCD detects changes and applies them to the Kubernetes cluster — ensuring the cluster state always matches the Git repository.

## ⚙️ ArgoCD Setup Steps
### 1. Deploy ArgoCD on the EKS Cluster

ArgoCD was deployed inside the argocd namespace using the official manifest:
```
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
```

<img width="1090" height="158" alt="Screenshot (367)" src="https://github.com/user-attachments/assets/873d7596-aeed-4f0a-a1e1-98760c39e492" />
<img width="1085" height="431" alt="Screenshot (368)" src="https://github.com/user-attachments/assets/cb8356d8-1d6d-4e4a-8c17-8f54cfe1157e" />

### 2. Verify ArgoCD Installation

To make sure ArgoCD is successfully deployed, check the pods inside the argocd namespace:

```
kubectl get pods -n argocd
```
<img width="1090" height="164" alt="Screenshot (369)" src="https://github.com/user-attachments/assets/54d2c45c-1f44-4553-9f90-a8c76e4acd43" />

### 3. Access ArgoCD Web UI

Forward the ArgoCD API server port to access the GUI:
```
kubectl port-forward svc/argocd-server -n argocd 80:443
```
Then open your browser and visit:

https://localhost:80

<img width="1366" height="684" alt="Screenshot (380)" src="https://github.com/user-attachments/assets/e2e39123-b132-49e2-9d9e-3463f9e54f35" />

### 4. Login Credentials

Get the initial admin password:
```
kubectl -n argocd get secret argocd-initial-admin-secret \
  -o jsonpath="{.data.password}" | base64 -d && echo
```
<img width="1087" height="80" alt="Screenshot (392)" src="https://github.com/user-attachments/assets/5c1d3435-050e-44e3-ba03-53bcca79bc7e" />

Then log in with:

Username: admin

Password: (the decoded value above)

## 🔗 Connect GitHub Repository

After login:

Go to Settings → Repositories

Click "Connect Repo using HTTPS"

Enter repo URL:

https://github.com/AhmedSabeh/The-Devopsers-Project

Click Connect.

## 🧱 Create Application via GUI

### In the ArgoCD dashboard:

### Click New App

### Fill in:

-  Application Name: devopsers-app

-  Project: default

-  Sync Policy: Automatic

-  Repository URL: https://github.com/AhmedSabeh/depi-final-project/The-Devopsers-Project

-  Path: Kubernetes/

-  Cluster URL: https://kubernetes.default.svc

-  Namespace: devopsers

-  Click Create.

-  ArgoCD will automatically pull manifests from your GitHub repo and deploy them to your EKS cluster.

<img width="1366" height="686" alt="Screenshot (362)" src="https://github.com/user-attachments/assets/1fbd3651-1c20-4554-b4f9-1e8147bec8d4" />
<img width="1366" height="680" alt="Screenshot (363)" src="https://github.com/user-attachments/assets/e4eaad68-74a0-45a0-83f2-d52dd185a08f" />

## 🔄 Automatic Sync and Self-Healing

-  Auto-Sync ensures any new commit in the repo is applied to the cluster automatically.

-  Self-Healing ensures that if any resource is modified manually in the cluster, ArgoCD will revert it back to match the Git repository.

-  If you edit the number of replicas in your Kubernetes/deployment.yaml file:

-  Change replicas from 2 → 3

-  → ArgoCD will detect the change and automatically scale up the deployment to 3 pods.

<img width="1366" height="692" alt="Screenshot (361)" src="https://github.com/user-attachments/assets/e2f41de9-3966-43c7-b3a5-50de1f275a84" />

-  This behavior confirms that the EKS cluster state is always synchronized with your Git repository.

## 📊 Monitoring & Status

-  In the ArgoCD Dashboard, you can monitor:

-  Deployment health (green = healthy)

-  Sync status (synced / out of sync)

-  Commit hash and deployment version

-  Kubernetes resource visualization
