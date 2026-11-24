# Centralized Logging (Loki + Grafana)

## Purpose
The application currently exposes container logs through Kubernetes. This guide adds a centralized log backend using Grafana Loki and a log collector so logs can be queried centrally.

## Install
Run these commands against a working Kubernetes cluster with Helm installed:

```bash
helm repo add grafana https://grafana.github.io/helm-charts
helm repo update
helm upgrade --install loki grafana/loki \
  --namespace monitoring --create-namespace \
  --set deploymentMode=SingleBinary \
  --set loki.auth_enabled=false \
  --set singleBinary.replicas=1
```

> This is a small lab configuration, not a production-secure deployment. For production, enable authentication, persistent storage, resource sizing, retention policies and network restrictions. Verify chart values against the selected chart version before upgrading.

## Log collection
Install Grafana Alloy (recommended collector) using the official Grafana Helm chart and configure it to discover Kubernetes pod logs and send them to the Loki write endpoint in the monitoring namespace. Keep collector configuration in version control and restrict its Kubernetes RBAC permissions to the namespaces it must observe.

## Grafana
Add Loki as a Grafana data source:
- Type: Loki
- URL (inside the cluster): `http://loki-gateway.monitoring.svc.cluster.local` when the gateway service is enabled by the chart.
- Explore query example: `{namespace="default"}`

Service names vary with chart version and deployment mode. Confirm them with:
```bash
kubectl get svc -n monitoring
kubectl get pods -n monitoring
```

## Validation
Generate application traffic, then inspect logs in Grafana Explore. Also verify collector health and Loki readiness:
```bash
kubectl get pods -n monitoring
kubectl logs -n monitoring -l app.kubernetes.io/name=alloy --tail=50
```

This document is an implementation guide; centralized log collection is not considered demonstrated until the collector is installed, connected to Loki, and logs are visible in Grafana.
