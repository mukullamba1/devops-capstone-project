
# 🚀 End-to-End DevOps Automation Platform

A complete DevOps Capstone project demonstrating an automated software delivery workflow using GitHub Actions, Docker, Kubernetes, Prometheus and Grafana.

## 👨‍💻 Project Overview

This project demonstrates how an application can be built, containerized, tested, scanned, deployed and monitored using modern DevOps tools.

## 🏗️ Architecture

```text
Developer
   |
   v
GitHub Repository
   |
   v
GitHub Actions (CI/CD)
   |
   +----> Trivy Security Scan
   |
   v
Docker Build & Push
   |
   v
Docker Hub
   |
   v
Kubernetes Deployment
   |
   v
Kubernetes Service
   |
   v
Application
   |
   v
Prometheus + Grafana
```

## 🛠️ Technologies Used

| Technology | Purpose |
|---|---|
| GitHub | Source Code Management |
| GitHub Actions | CI/CD Automation |
| Docker | Containerization |
| Docker Hub | Container Image Registry |
| Kubernetes | Container Orchestration |
| Prometheus | Metrics Collection |
| Grafana | Monitoring Dashboard |
| Trivy | Container Security Scanning |
| Nginx | Web Application Server |

## 📁 Project Structure

```text
devops-capstone-project/
│
├── .github/
│   └── workflows/
│       ├── ci-cd.yml
│       └── docker-publish.yml
│
├── kubernetes/
│   ├── deployment.yaml
│   └── service.yaml
│
├── evidence/
│   └── Project Screenshots
│
├── index.html
├── Dockerfile
└── README.md
```

## ⚙️ Project Setup

### 1. Clone Repository

```bash
git clone https://github.com/mukullamba1/devops-capstone-project.git
cd devops-capstone-project
```

### 2. Build Docker Image

```bash
docker build -t devops-capstone-project .
```

### 3. Run Docker Container

```bash
docker run -d -p 8080:80 --name devops-app devops-capstone-project
```

Open in browser:

```text
http://localhost:8080
```

### 4. Deploy on Kubernetes

```bash
kubectl apply -f kubernetes/deployment.yaml
kubectl apply -f kubernetes/service.yaml
```

### 5. Verify Deployment

```bash
kubectl get pods
kubectl get deployments
kubectl get services
```

### 6. Check Application Logs

```bash
kubectl logs deployment/devops-capstone --tail=30
```

### 7. Monitor Cluster Resources

```bash
kubectl top nodes
kubectl top pods
```

## 🔄 CI/CD Pipeline

The GitHub Actions workflows demonstrate:

1. Source code checkout.
2. CI/CD workflow execution.
3. Docker image build and publishing.
4. Trivy security scanning.

Docker images are published to Docker Hub using GitHub repository secrets.

## 📊 Monitoring

Prometheus and Grafana were deployed using the Prometheus Community Helm chart.

```bash
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts

helm repo update

helm install prometheus prometheus-community/kube-prometheus-stack \
  --namespace monitoring \
  --create-namespace \
  --set grafana.adminPassword=YOUR_GRAFANA_PASSWORD \
  --set prometheus.prometheusSpec.retention=2d
```

## ♻️ Self-Healing Demonstration

```bash
kubectl delete pod POD_NAME
kubectl get pods -w
```

Kubernetes automatically creates a replacement pod through the Deployment's ReplicaSet.

## 💾 Backup and Restore

Create backup:

```bash
mkdir -p ~/devops-backup

kubectl get deployment devops-capstone -o yaml > ~/devops-backup/deployment-backup.yaml

kubectl get service devops-capstone-service -o yaml > ~/devops-backup/service-backup.yaml
```

Restore:

```bash
kubectl apply -f ~/devops-backup/deployment-backup.yaml

kubectl apply -f ~/devops-backup/service-backup.yaml

kubectl rollout status deployment/devops-capstone
```

## 🔁 Rolling Update

```bash
kubectl set image deployment/devops-capstone devops-capstone=nginx:1.27

kubectl rollout status deployment/devops-capstone
```

Check rollout:

```bash
kubectl rollout history deployment/devops-capstone
kubectl get pods
```

## 🔐 Security

- Trivy security scanning in the CI/CD workflow.
- Docker Hub authentication through GitHub Secrets.
- No access tokens or passwords stored in source code.

## 📸 Project Evidence

Actual implementation screenshots are available in the [`evidence`](evidence/) folder.

Evidence includes:

- GitHub Actions workflow
- Docker image publishing
- Kubernetes deployment
- Prometheus and Grafana dashboards
- Application logs
- Kubernetes self-healing
- Backup and restore
- Rolling update

## 🎯 Learning Outcomes

- CI/CD automation
- Docker containerization
- Kubernetes deployment and orchestration
- Monitoring and observability
- Security scanning
- Backup and recovery
- Rolling update strategy
- 
---

## 📚 Additional Project Documentation

- [Complete Command Reference](COMMANDS.md)
- [System Architecture](ARCHITECTURE.md)
- [Troubleshooting Guide](TROUBLESHOOTING.md)
- [Project Implementation Evidence](evidence/)

## 📦 Container Image

Docker Hub: [devops-capstone-project](https://hub.docker.com/r/mukullambacapstone/devops-capstone-project)

## 📌 Project Status

The project demonstrates CI/CD workflows, Docker image publishing, Kubernetes deployment, monitoring, logging inspection, backup and restore, self-healing and rolling updates.

Infrastructure provisioning through Terraform/Ansible, centralized logging and automatic Kubernetes deployment from GitHub Actions are not currently implemented.


## 👨‍🎓 Capstone Project

**Project:** End-to-End DevOps Automation Platform  
**Repository:** devops-capstone-project
