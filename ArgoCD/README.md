🚀 ArgoCD — GitOps Continuous Deployment

This section documents the ArgoCD setup and deployment process used in the DEPI Final DevOps Project for automating Kubernetes deployments.

🧩 Overview

ArgoCD is a GitOps continuous delivery tool that automatically synchronizes and deploys Kubernetes manifests from this GitHub repository to the EKS cluster.

Goal:
Whenever new code or configuration is pushed to GitHub, ArgoCD detects changes and applies them to the Kubernetes cluster — ensuring the cluster state always matches the Git repository.

⚙️ ArgoCD Setup Steps
1. Deploy ArgoCD on the EKS Cluster

ArgoCD was deployed inside the argocd namespace using the official manifest:

kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

2. Access ArgoCD Web UI

Forward the ArgoCD API server port to access the GUI:

kubectl port-forward svc/argocd-server -n argocd 80:443

Then open your browser and visit:

https://localhost:80

3. Login Credentials

Get the initial admin password:

kubectl -n argocd get secret argocd-initial-admin-secret \
  -o jsonpath="{.data.password}" | base64 -d && echo


Then log in with:

Username: admin

Password: (the decoded value above)

🔗 Connect GitHub Repository

After login:

Go to Settings → Repositories

Click "Connect Repo using HTTPS"

Enter your repo URL, for example:

https://github.com/AhmedSabeh/The-Devopsers-Project


Click Connect.

🧱 Create Application via GUI

In the ArgoCD dashboard:

Click New App

Fill in:

Application Name: devopsers-app

Project: default

Sync Policy: Automatic

Repository URL:
https://github.com/AhmedSabeh/depi-final-project/The-Devopsers-Project

Path:
Kubernetes/

Cluster URL:
https://kubernetes.default.svc

Namespace:
devopsers

Click Create.

ArgoCD will automatically pull manifests from your GitHub repo and deploy them to your EKS cluster.

🔄 Automatic Sync and Self-Healing

Auto-Sync ensures any new commit in the repo is applied to the cluster automatically.

Self-Healing ensures that if any resource is modified manually in the cluster, ArgoCD will revert it back to match the Git repository.

📊 Monitoring & Status

In the ArgoCD Dashboard, you can monitor:

Deployment health (green = healthy)

Sync status (synced / out of sync)

Commit hash and deployment version

Kubernetes resource visualization
