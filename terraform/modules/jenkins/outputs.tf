output "jenkins_service_name" {
  description = "Kubernetes service name for Jenkins"
  value       = kubernetes_service.jenkins.metadata[0].name
}

output "jenkins_port" {
  description = "Port Jenkins is exposed on"
  value       = var.jenkins_port
}

output "jenkins_agent_port" {
  description = "Port for Jenkins agents to connect"
  value       = 50000
}
