output "namespace_name" {
  description = "The name of the created namespace"
  value       = kubernetes_namespace.environment.metadata[0].name
}

output "namespace_labels" {
  description = "Labels applied to the namespace"
  value       = kubernetes_namespace.environment.metadata[0].labels
}
