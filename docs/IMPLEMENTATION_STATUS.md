# Implementation and Verification Status

This repository contains configuration and runbooks for the listed capabilities. A committed configuration file is not proof that a live cluster operation succeeded.

| Capability | Repository implementation | Live verification required |
|---|---|---|
| CI build, container smoke test, Trivy scan | GitHub Actions workflow | Confirm latest Actions run is green |
| Docker Hub publishing | GitHub Actions workflow | Confirm image tags exist in Docker Hub |
| Kubernetes application | Deployment and Service manifests | Confirm pods are Ready and service responds |
| Terraform | Kubernetes provider resources in `terraform/` | Run init, validate, plan and apply with a reachable cluster |
| Ansible | Local playbook in `ansible/deploy.yml` | Run playbook with kubectl and cluster access |
| Centralized logging | Loki + collector setup guide | Install collector, query logs in Grafana |
| Automated Kubernetes deployment | GitHub Actions workflow | Add `KUBE_CONFIG_B64` and `DOCKERHUB_USERNAME` secrets; confirm successful run |
| Evidence | `evidence/` folder | Check that each screenshot is genuine and readable |

## Required GitHub Actions secrets
- `DOCKERHUB_USERNAME`: Docker Hub account username (also used by the existing image publishing workflow).
- `DOCKERHUB_TOKEN`: Docker Hub access token with push permission.
- `KUBE_CONFIG_B64`: Base64-encoded kubeconfig for a reachable cluster. Use a dedicated, least-privilege service account. Never commit kubeconfig or tokens.

## Run Terraform
```bash
cd terraform
terraform init
terraform fmt -check
terraform validate
terraform plan
terraform apply
```

## Run Ansible
```bash
ansible-playbook ansible/deploy.yml
```

## Security note
Do not store passwords, tokens, kubeconfig files, or private keys in the repository. Rotate any credential that has been exposed.
