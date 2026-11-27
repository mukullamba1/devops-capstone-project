terraform {
  required_version = ">= 1.5.0"
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.35"
    }
  }
}

variable "kubeconfig_path" {
  description = "Path to a kubeconfig with permission to manage the application namespace."
  type        = string
  default     = "~/.kube/config"
}

variable "namespace" {
  description = "Kubernetes namespace for the capstone application."
  type        = string
  default     = "devops"
}

variable "image" {
  description = "Container image to deploy."
  type        = string
  default     = "mukullambacapstone/devops-capstone-project:latest"
}

provider "kubernetes" {
  config_path = pathexpand(var.kubeconfig_path)
}

resource "kubernetes_namespace_v1" "app" {
  metadata {
    name = var.namespace
    labels = {
      app        = "devops-capstone"
      managed_by = "terraform"
    }
  }
}

resource "kubernetes_deployment_v1" "app" {
  metadata {
    name      = "devops-capstone"
    namespace = kubernetes_namespace_v1.app.metadata[0].name
    labels    = { app = "devops-capstone" }
  }
  spec {
    replicas = 2
    selector {
      match_labels = { app = "devops-capstone" }
    }
    template {
      metadata {
        labels = { app = "devops-capstone" }
      }
      spec {
        container {
          name  = "devops-capstone"
          image = var.image
          port {
            container_port = 80
          }
          resources {
            requests = { cpu = "100m", memory = "64Mi" }
            limits   = { cpu = "200m", memory = "128Mi" }
          }
          readiness_probe {
            http_get {
              path = "/"
              port = 80
            }
            initial_delay_seconds = 5
            period_seconds        = 10
          }
          liveness_probe {
            http_get {
              path = "/"
              port = 80
            }
            initial_delay_seconds = 15
            period_seconds        = 20
          }
        }
      }
    }
  }
}

resource "kubernetes_service_v1" "app" {
  metadata {
    name      = "devops-capstone-service"
    namespace = kubernetes_namespace_v1.app.metadata[0].name
  }
  spec {
    selector = { app = "devops-capstone" }
    port {
      port        = 80
      target_port = 80
      node_port   = 30080
    }
    type = "NodePort"
  }
}

output "namespace" {
  value = kubernetes_namespace_v1.app.metadata[0].name
}

output "service_name" {
  value = kubernetes_service_v1.app.metadata[0].name
}
