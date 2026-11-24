
# DevOps Capstone - Troubleshooting Guide

This document records common issues and their solutions during project deployment and monitoring.

## 1. Kubernetes ImagePullBackOff

**Problem:** Kubernetes cannot pull the application image.

**Check:**
```bash
kubectl get pods
kubectl describe pod POD_NAME
```

**Solution:** Verify the Docker Hub image name and tag in the Deployment.

```bash
kubectl set image deployment/devops-capstone devops-capstone=mukullambacapstone/devops-capstone-project:latest
kubectl rollout status deployment/devops-capstone
```

## 2. Check Kubernetes Pod Status

```bash
kubectl get pods -A
kubectl describe deployment devops-capstone
```

Ensure the application pods reach the Running state.

## 3. Metrics Server Not Showing Resource Usage

**Check:**
```bash
kubectl top nodes
kubectl top pods
```

If metrics are unavailable, verify Metrics Server status:

```bash
kubectl get pods -n kube-system
kubectl logs deployment/metrics-server -n kube-system
```

## 4. Grafana Access Issues

Check monitoring pods:

```bash
kubectl get pods -n monitoring
```

Start port forwarding:

```bash
kubectl port-forward -n monitoring svc/prometheus-grafana 3000:80 --address 0.0.0.0
```

Access Grafana through the configured playground port.

## 5. Application Logs

Check application logs:

```bash
kubectl logs deployment/devops-capstone --tail=30
```

Follow logs continuously:

```bash
kubectl logs -f deployment/devops-capstone
```

## 6. Verify Application Recovery

```bash
kubectl get pods
kubectl get deployments
kubectl get services
```

Check that the desired application replicas are available.

## 7. General Verification Commands

```bash
kubectl get nodes
kubectl get pods -A
kubectl get deployments
kubectl get services
kubectl top nodes
```

**Note:** These are troubleshooting procedures and verification commands. Actual results depend on the Kubernetes cluster and its current state.
