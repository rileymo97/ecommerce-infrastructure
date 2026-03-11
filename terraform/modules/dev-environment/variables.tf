variable "environment" {
  description = "The deployment environment"
  type        = string
}

variable "namespace" {
  description = "Kubernetes namespace to deploy into"
  type        = string
}

variable "db_port" {
  description = "Database port"
  type        = number
  default     = 5432
}

variable "cpu_request" {
  description = "CPU request for the environment"
  type        = string
  default     = "500m"
}

variable "memory_request" {
  description = "Memory request for the environment"
  type        = string
  default     = "512Mi"
}

variable "cpu_limit" {
  description = "CPU limit for the environment"
  type        = string
  default     = "1000m"
}

variable "memory_limit" {
  description = "Memory limit for the environment"
  type        = string
  default     = "1Gi"
}

variable "max_pods" {
  description = "Maximum number of pods in the environment"
  type        = string
  default     = "10"
}
