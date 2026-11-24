# 🚀 End-to-End DevOps Automation Platform

A DevOps capstone demonstrating containerized application delivery, CI/CD, Kubernetes orchestration, security scanning, infrastructure automation and observability.

## Student Details
- **Name:** Mukul
- **Roll Number:** 2301010167
- **Subject:** DevOps
- **Repository:** [devops-capstone-project](https://github.com/mukullamba1/devops-capstone-project)

## Architecture

```text
Developer -> GitHub -> GitHub Actions
                         |
              +----------+-----------+
              |                      |
          CI build/test          Docker build/push
              |                      |
          Trivy scan             Docker Hub
                                     |
                             Kubernetes Deployment
                                     |
                              Kubernetes Service
                                     |
                               Nginx Web App
                                     |
                         Prometheus + Grafana
                         (Loki guide available)
```

## Technology Stack

| Technology | Purpose |
|---|---|
| GitHub / GitHub Actions | Source control and CI/CD |
| Docker / Docker Hub | Container build and image registry |
| Kubernetes | Application orchestration and self-healing |
| Trivy | Container vulnerability scanning |
| Terraform | Declarative Kubernetes resource provisioning |
| Ansible | Repeatable Kubernetes deployment playbook |
| Prometheus / Grafana | Metrics and dashboards |
| Loki | Centralized logging implementation guide |
| Nginx | Web server for the sample application |

## Repository Layout

```text
.github/workflows/   CI, image publishing, Kubernetes deploy, Terraform validation
kubernetes/          Kubernetes Deployment and Service manifests
terraform/           Terraform Kubernetes provider configuration
ansible/             Ansible deployment playbook
docs/                Implementation status and centralized logging guide
evidence/            Project screenshots captured during lab execution
Dockerfile           Container build instructions
index.html           Sample web application
COMMANDS.md          Command reference
ARCHITECTURE.md      Architecture and workflow notes
TROUBLESHOOTING.md   Common operational issues
```

## Quick Start: Docker

```bash
git clone https://github.com/mukullamba1/devops-capstone-project.git
cd devops-capstone-project
docker build -t devops-capstone-project .
docker run --rm -p 8080:80 devops-capstone-project
```

Open `http://localhost:8080`.

## Kubernetes Deployment

```bash
kubectl apply -f kubernetes/deployment.yaml
kubectl apply -f kubernetes/service.yaml
kubectl rollout status deployment/devops-capstone
kubectl get pods,deploy,svc
```

The sample manifest uses two replicas, resource requests/limits and a NodePort service on port 30080.

## CI/CD Workflows

- **DevOps Capstone CI-CD:** builds the image, runs a container smoke test and performs a Trivy scan.
- **Docker Hub Image Publishing:** builds and publishes `latest` and commit-SHA tags. Configure `DOCKERHUB_USERNAME` and `DOCKERHUB_TOKEN` in GitHub Actions secrets.
- **Deploy to Kubernetes:** runs after a successful image-publishing workflow. Configure `KUBE_CONFIG_B64` with a base64-encoded kubeconfig for a reachable cluster and `DOCKERHUB_USERNAME`. Use a dedicated least-privilege service account.
- **Terraform Validation:** checks formatting, initialization and configuration validity on Terraform changes.

Never commit credentials, tokens or kubeconfig files.

## Infrastructure Automation

### Terraform
```bash
cd terraform
terraform init
terraform fmt -check -recursive
terraform validate
terraform plan
terraform apply
```
Set `kubeconfig_path` and other inputs using a local `terraform.tfvars` file. The example file is `terraform/terraform.tfvars.example`. Terraform requires a reachable Kubernetes cluster for plan/apply.

### Ansible
```bash
ansible-playbook ansible/deploy.yml
```
Ansible requires Ansible, kubectl and a working Kubernetes context.

## Monitoring and Recovery

Prometheus and Grafana can be installed using the Helm commands in [COMMANDS.md](COMMANDS.md). Demonstrations include checking logs, pod self-healing, configuration backup/restore and rolling updates. See [ARCHITECTURE.md](ARCHITECTURE.md) and [TROUBLESHOOTING.md](TROUBLESHOOTING.md).

Centralized logging setup instructions are in [docs/CENTRALIZED_LOGGING.md](docs/CENTRALIZED_LOGGING.md). Loki and a collector must be installed and verified before claiming centralized log aggregation is operational.

## Evidence

See [evidence/](evidence/) for screenshots captured during the lab. Screenshots should be genuine outputs from the actual tools and environment; documentation or workflow configuration alone is not proof of a successful live deployment.

## Implementation Status

See [docs/IMPLEMENTATION_STATUS.md](docs/IMPLEMENTATION_STATUS.md) for the difference between repository configuration and live verification. Terraform, Ansible, Loki and automated cluster deployment are now represented by repository configurations/runbooks; they are **not claimed as live-tested** until their validation and deployment steps succeed in a real cluster.

## References
- [Docker Hub image](https://hub.docker.com/r/mukullambacapstone/devops-capstone-project)
- [GitHub Actions](https://github.com/mukullamba1/devops-capstone-project/actions)
