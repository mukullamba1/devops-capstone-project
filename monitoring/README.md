# Monitoring assets

This directory contains version-controlled examples for the monitoring stack.

## Included

- `alloy/config.alloy`: Kubernetes pod discovery, namespace/pod/container labels, and Loki forwarding.
- `grafana/provisioning/datasources/loki.yaml`: Grafana Loki datasource provisioning.
- `prometheus/alerts.yaml`: Prometheus Operator alert rules for application availability and restart spikes.

## Important before applying

1. Confirm the Loki gateway Service exists:
   `kubectl get svc -n monitoring`
2. Confirm Alloy has `get/list/watch pods` and `get pods/log` RBAC in the namespaces it should collect.
3. Verify the Alloy chart mounts the supplied config at its expected path before upgrading the release.
4. Verify the Prometheus Operator CRD exists:
   `kubectl get crd prometheusrules.monitoring.coreos.com`
5. Apply alert rules only after the CRD check:
   `kubectl apply -f monitoring/prometheus/alerts.yaml`
6. Configure the Grafana datasource through the chart's supported provisioning mechanism; the YAML here is a provisioning example, not a live datasource confirmation.

## Loki validation

Generate an application request, then query Loki over a current time range:

```bash
kubectl exec -n devops deploy/devops-capstone -- wget -qO- http://127.0.0.1/ >/dev/null
kubectl port-forward -n monitoring svc/loki-gateway 3100:80
curl -G 'http://127.0.0.1:3100/loki/api/v1/query_range' \
  --data-urlencode 'query={namespace="devops",pod=~"devops-capstone.*"}' \
  --data-urlencode "start=$(date -u -d '30 minutes ago' +%s)000000000" \
  --data-urlencode "end=$(date -u +%s)000000000"
```

A successful HTTP response with an empty `result` does not prove ingestion; the application log line must appear in the returned streams.
