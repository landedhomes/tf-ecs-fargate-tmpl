output "combined_environment" {
  value = [for key, val in var.container_environment : { name = key, value = val }]
}