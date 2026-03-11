terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.0"
    }
  }
}

provider "kubernetes" {
  config_path    = "~/.kube/config"
  config_context = "minikube"
}

module "minikube" {
  source      = "./modules/minikube"
  environment = var.environment
  namespace   = var.namespace
}

module "database" {
  source      = "./modules/database"
  environment = var.environment
  namespace   = var.namespace
  db_port     = var.db_port
}

module "jenkins" {
  source        = "./modules/jenkins"
  environment   = var.environment
  namespace     = var.namespace
  jenkins_port  = var.jenkins_port
}

module "dev-environment" {
  source      = "./modules/dev-environment"
  environment = var.environment
  namespace   = var.namespace
}
