variable "environment" {
  description = "The deployment environment"
  type        = string
}

variable "namespace" {
  description = "Kubernetes namespace to deploy into"
  type        = string
}

variable "db_port" {
  description = "Port to expose PostgreSQL on"
  type        = number
  default     = 5432
}
