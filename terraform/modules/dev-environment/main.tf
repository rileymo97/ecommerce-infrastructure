resource "kubernetes_config_map" "environment_config" {
  metadata {
    name      = "environment-config-${var.environment}"
    namespace = var.namespace
    labels = {
      environment = var.environment
      managed-by  = "terraform"
    }
  }

  data = {
    ENVIRONMENT          = var.environment
    PRODUCT_SERVICE_URL  = "http://product-service-${var.environment}:3001"
    ORDER_SERVICE_URL    = "http://order-service-${var.environment}:3002"
    FRONTEND_URL         = "http://frontend-${var.environment}:3000"
    DB_HOST              = "postgres-${var.environment}"
    DB_PORT              = tostring(var.db_port)
    DB_NAME              = "ecommerce"
  }
}

resource "kubernetes_resource_quota" "environment_quota" {
  metadata {
    name      = "environment-quota-${var.environment}"
    namespace = var.namespace
    labels = {
      environment = var.environment
      managed-by  = "terraform"
    }
  }

  spec {
    hard = {
      "requests.cpu"    = var.cpu_request
      "requests.memory" = var.memory_request
      "limits.cpu"      = var.cpu_limit
      "limits.memory"   = var.memory_limit
      "pods"            = var.max_pods
    }
  }
}
