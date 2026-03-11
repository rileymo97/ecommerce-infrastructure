output "config_map_name" {
  description = "Name of the environment ConfigMap"
  value       = kubernetes_config_map.environment_config.metadata[0].name
}

output "environment_urls" {
  description = "Service URLs for this environment"
  value = {
    frontend        = "http://frontend-${var.environment}:3000"
    product_service = "http://product-service-${var.environment}:3001"
    order_service   = "http://order-service-${var.environment}:3002"
    database        = "postgres-${var.environment}:${var.db_port}"
  }
}
