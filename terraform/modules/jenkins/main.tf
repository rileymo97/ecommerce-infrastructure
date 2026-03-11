resource "kubernetes_deployment" "jenkins" {
  metadata {
    name      = "jenkins-${var.environment}"
    namespace = var.namespace
    labels = {
      app         = "jenkins"
      environment = var.environment
      managed-by  = "terraform"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app         = "jenkins"
        environment = var.environment
      }
    }

    template {
      metadata {
        labels = {
          app         = "jenkins"
          environment = var.environment
        }
      }

      spec {
        container {
          name  = "jenkins"
          image = "jenkins/jenkins:lts-alpine"

          port {
            container_port = 8080
          }

          port {
            container_port = 50000
          }

          volume_mount {
            name       = "jenkins-home"
            mount_path = "/var/jenkins_home"
          }
resources {
  requests = {
    cpu    = "200m"
    memory = "256Mi"
  }
  limits = {
    cpu    = "500m"
    memory = "512Mi"
  }
}
        }

        volume {
          name = "jenkins-home"
          empty_dir {}
        }
      }
    }
  }
}


resource "kubernetes_service" "jenkins" {
  metadata {
    name      = "jenkins-${var.environment}"
    namespace = var.namespace
    labels = {
      app         = "jenkins"
      environment = var.environment
      managed-by  = "terraform"
    }
  }

  spec {
    selector = {
      app         = "jenkins"
      environment = var.environment
    }

    port {
      name        = "http"
      port        = var.jenkins_port
      target_port = 8080
    }

    port {
      name        = "agent"
      port        = 50000
      target_port = 50000
    }

    type = "NodePort"
  }
}
