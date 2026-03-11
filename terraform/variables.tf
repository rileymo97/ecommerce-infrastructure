variable "environment" {
  description = "The deployment environment (dev, staging, prod)"
  type        = string
}

variable "namespace" {
  description = "Kubernetes namespace for this environment"
  type        = string
}

variable "db_port" {
  description = "Port for the PostgreSQL database"
  type        = number
  default     = 5432
}

variable "jenkins_port" {
  description = "Port for Jenkins"
  type        = number
  default     = 8080
}

variable "replicas" {
  description = "Number of replicas for services"
  type        = number
  default     = 1
}
