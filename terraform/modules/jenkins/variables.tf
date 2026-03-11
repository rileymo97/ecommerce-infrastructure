variable "environment" {
  description = "The deployment environment"
  type        = string
}

variable "namespace" {
  description = "Kubernetes namespace to deploy into"
  type        = string
}

variable "jenkins_port" {
  description = "Port to expose Jenkins on"
  type        = number
  default     = 8080
}
