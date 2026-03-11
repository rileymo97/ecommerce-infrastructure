# Creates a PostgreSQL deployment inside the Kubernetes namespace
resource "kubernetes_deployment" "postgres" {
  metadata {
    name      = "postgres-${var.environment}"
    namespace = var.namespace
    labels = {
      app         = "postgres"
      environment = var.environment
      managed-by  = "terraform"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app         = "postgres"
        environment = var.environment
      }
    }

    template {
      metadata {
        labels = {
          app         = "postgres"
          environment = var.environment
        }
      }

      spec {
        container {
          name  = "postgres"
          image = "postgres:15-alpine"

          port {
            container_port = 5432
          }

          env {
            name  = "POSTGRES_DB"
            value = "ecommerce"
          }

          env {
            name  = "POSTGRES_USER"
            value = "postgres"
          }

          env {
            name  = "POSTGRES_PASSWORD"
            value = "password"
          }
	  resources {
            requests = {
            cpu    = "100m"
            memory = "128Mi"
    	  }
    	  limits = {
      	    cpu    = "250m"
      	    memory = "256Mi"
    	  }
	  }
        }
      }
    }
  }
}

# Creates a Kubernetes service to expose PostgreSQL within the cluster
resource "kubernetes_service" "postgres" {
  metadata {
    name      = "postgres-${var.environment}"
    namespace = var.namespace
    labels = {
      app         = "postgres"
      environment = var.environment
      managed-by  = "terraform"
    }
  }

  spec {
    selector = {
      app         = "postgres"
      environment = var.environment
    }

    port {
      port        = var.db_port
      target_port = 5432
    }

    type = "ClusterIP"
  }
}
