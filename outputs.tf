
output "gcloud_region" {
  value       = var.gcloud_region
  description = "GCloud Region"
}

output "project_id" {
  value       = var.project_id
  description = "GCloud Project ID"
}

output "machine_type" {
  value       = var.node_machine_type
  description = "GKE Machine Type"
}