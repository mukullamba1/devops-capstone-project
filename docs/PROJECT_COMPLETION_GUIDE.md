# Project Handover and Final Validation

## Repository

Project: [devops-capstone-project](https://github.com/mukullamba1/devops-capstone-project)

## Live lab state last observed

The Killercoda cluster was observed with both Kubernetes nodes Ready, two application replicas Running, and Prometheus, Grafana, Loki, and Alloy pods Running.

The application generated Nginx HTTP 200 access logs. Loki queries returned Canary streams but no application streams, so end-to-end application log ingestion was **not verified** at the time of this handover.

## Repository capabilities

The repository includes Docker build instructions, Kubernetes Deployment and Service manifests, GitHub Actions workflows for CI, image publishing, Kubernetes deployment and Terraform validation, Terraform and Ansible examples, architecture documentation, troubleshooting notes, and evidence screenshots.

## Final validation checklist

- [ ] Latest CI workflow run succeeds (build, smoke test and Trivy step).
- [ ] Docker Hub contains both `latest` and commit-SHA image tags.
- [ ] Kubernetes Deployment has two available replicas.
- [ ] Service responds with HTTP 200 from outside the pod.
- [ ] Terraform `fmt -check`, `init -backend=false`, and `validate` succeed.
- [ ] Ansible playbook completes against the intended Kubernetes context.
- [ ] Prometheus scrapes application/cluster targets and Grafana dashboards load.
- [ ] Loki datasource is healthy in Grafana.
- [ ] A fresh application access-log line is returned by a Loki query.
- [ ] Alert rules are loaded and visible in Prometheus.
- [ ] Evidence screenshots are genuine, current, and readable.

## Useful commands

```bash
kubectl get nodes
kubectl get pods -n devops -o wide
kubectl get svc -n devops
kubectl get pods -n monitoring
kubectl rollout status deployment/devops-capstone -n devops
kubectl logs -n devops deploy/devops-capstone --tail=20 --timestamps
```

## Security and honesty

Never commit GitHub tokens, Docker Hub tokens, kubeconfig files, passwords, or private keys. Workflow configuration is not the same as a successful workflow run; a running monitoring pod is not proof that its data pipeline works. Mark each item complete only after the corresponding live check passes.
