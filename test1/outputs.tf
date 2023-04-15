

output "project_number" {
  value = data.google_project.my_proj.number
}

output "project_info" {
  value = data.google_project.my_proj
}

output "vm_info" {
  description = "vm info"
  value       = google_compute_instance.vm_arm
  sensitive   = true
}

output "vm_public_ip" {
  value = google_compute_instance.vm_arm.network_interface[0].access_config[0].nat_ip
}

output "vm_private_ip" {
  value = google_compute_instance.vm_arm.network_interface[0].network_ip
}

