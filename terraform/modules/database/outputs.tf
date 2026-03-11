output "db_service_name" {
  description = "Kubernetes service name for PostgreSQL"
  value       = kubernetes_service.postgres.metadata[0].name
}

output "db_port" {
  description = "Port PostgreSQL is exposed on"
  value       = var.db_port
}

output "db_connection_string" {
  description = "PostgreSQL connection string for application services"
  value       = "postgresql://postgres:password@postgres-${var.environment}:${var.db_port}/ecommerce"
}
