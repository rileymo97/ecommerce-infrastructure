output "cluster_endpoint" {
  description = "Minikube cluster endpoint for Jenkins pipeline"
  value       = "https://$(minikube ip):8443"
}

output "namespace" {
  description = "Kubernetes namespace for this environment"
  value       = var.namespace
}

output "docker_registry" {
  description = "Local Docker registry URL"
  value       = "localhost:5000"
}

output "frontend_url" {
  description = "Frontend service URL"
  value       = "http://$(minikube ip):3000"
}

output "product_service_url" {
  description = "Product service URL"
  value       = "http://$(minikube ip):3001"
}

output "order_service_url" {
  description = "Order service URL"
  value       = "http://$(minikube ip):3002"
}

output "jenkins_url" {
  description = "Jenkins URL for CI/CD pipeline"
  value       = "http://$(minikube ip):${var.jenkins_port}"
}
