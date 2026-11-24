
# DevOps Capstone - Complete Command Reference

This document contains the commands used to build, deploy, monitor, recover and manage the DevOps Capstone application.

## 1. Clone the GitHub Repository

```bash
git clone https://github.com/mukullamba1/devops-capstone-project.git
cd devops-capstone-project
```

## 2. Docker Commands

Build the Docker image:

```bash
docker build -t devops-capstone-project .
```

Run the application:

```bash
docker run -d -p 8080:80 --name devops-app devops-capstone-project
```

Check running containers:

```bash
docker ps
```

View container logs:

```bash
docker logs devops-app
```

Stop and remove the container:

```bash
docker stop devops-app
docker rm devops-app
```

## 3. Kubernetes Deployment

Apply deployment:

```bash
kubectl apply -f kubernetes/deployment.yaml
```

Apply service:

```bash
kubectl apply -f kubernetes/service.yaml
```

Check resources:

```bash
kubectl get pods
kubectl get deployments
kubectl get services
kubectl get nodes
```

Describe deployment:

```bash
kubectl describe deployment devops-capstone
```

Check application logs:

```bash
kubectl logs deployment/devops-capstone --tail=30
```

## 4. Kubernetes Self-Healing

Delete one application pod:

```bash
kubectl delete pod POD_NAME
```

Watch Kubernetes recreate the pod:

```bash
kubectl get pods -w
```

The Deployment's ReplicaSet automatically creates a replacement pod to maintain the desired replica count.

## 5. Kubernetes Rolling Update

Update the application image:

```bash
kubectl set image deployment/devops-capstone devops-capstone=nginx:1.27
```

Check rollout status:

```bash
kubectl rollout status deployment/devops-capstone
```

Check rollout history:

```bash
kubectl rollout history deployment/devops-capstone
```

Restore the project image:

```bash
kubectl set image deployment/devops-capstone devops-capstone=mukullambacapstone/devops-capstone-project:latest
kubectl rollout status deployment/devops-capstone
```

## 6. Backup and Restore

Create backup directory:

```bash
mkdir -p ~/devops-backup
```

Backup Deployment:

```bash
kubectl get deployment devops-capstone -o yaml > ~/devops-backup/deployment-backup.yaml
```

Backup Service:

```bash
kubectl get service devops-capstone-service -o yaml > ~/devops-backup/service-backup.yaml
```

Check backup files:

```bash
ls -lh ~/devops-backup/
```

Restore Deployment:

```bash
kubectl apply -f ~/devops-backup/deployment-backup.yaml
```

Restore Service:

```bash
kubectl apply -f ~/devops-backup/service-backup.yaml
```

Verify restoration:

```bash
kubectl rollout status deployment/devops-capstone
kubectl get pods,deploy,svc
```

## 7. Metrics Server

Install Metrics Server:

```bash
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml
```

Check node resource usage:

```bash
kubectl top nodes
```

Check pod resource usage:

```bash
kubectl top pods
```

## 8. Prometheus and Grafana Monitoring

Add Helm repository:

```bash
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
```

Update Helm repositories:

```bash
helm repo update
```

Install monitoring stack:

```bash
helm install prometheus prometheus-community/kube-prometheus-stack \
  --namespace monitoring \
  --create-namespace \
  --set grafana.adminPassword=YOUR_GRAFANA_PASSWORD \
  --set prometheus.prometheusSpec.retention=2d
```

Check monitoring resources:

```bash
kubectl get pods -n monitoring
```

Access Grafana through port forwarding:

```bash
kubectl port-forward -n monitoring svc/prometheus-grafana 3000:80 --address 0.0.0.0
```

Grafana URL:

```text
http://localhost:3000
```

Login username: `admin`

Use the Grafana password configured during installation.

## 9. Application Logs

```bash
kubectl logs deployment/devops-capstone --tail=30
```

Follow live logs:

```bash
kubectl logs -f deployment/devops-capstone
```

## 10. CI/CD Workflow

CI/CD workflow file:

```text
.github/workflows/ci-cd.yml
```

Docker publishing workflow:

```text
.github/workflows/docker-publish.yml
```

GitHub Actions can be monitored from the repository's Actions tab.

Docker Hub image:

```text
mukullambacapstone/devops-capstone-project:latest
```

## 11. Final Verification

```bash
kubectl get nodes
kubectl get pods -A
kubectl get deployments
kubectl get services
kubectl top nodes
kubectl top pods
```

## Important Notes

- Replace `POD_NAME` with the actual pod name shown by `kubectl get pods`.
- Replace `YOUR_GRAFANA_PASSWORD` with the password configured for your Grafana installation.
- Kubernetes commands require a working cluster and kubectl access.
- Docker commands require Docker to be installed and running.
- Monitoring commands require Helm and the monitoring stack.
- These commands document the project demonstrations; they are not all executed automatically by GitHub Actions.
