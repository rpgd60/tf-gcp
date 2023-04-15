

# output "project_number" {
#   value = data.google_project.my_proj.number
# }

# output "project_info" {
#   value = data.google_project.my_proj
# }

# output "vm_info" {
#   description = "vm info"
#   value       = google_compute_instance.vm_arm
#   sensitive   = true
# }

# output "vm_public_ip" {
#   value = google_compute_instance.vm_arm.network_interface[0].access_config[0].nat_ip
# }

# output "vm_private_ip" {
#   value = google_compute_instance.vm_arm.network_interface[0].network_ip
# }

output "ssh_a" {
  value = [for i in range(var.num_vms) : "gcloud compute ssh --zone ${google_compute_instance.vma[i].zone} ${google_compute_instance.vma[i].name} --project ${data.google_project.my_proj.project_id}"]
}

output "ssh_test" {
    value =  [ for i in range(var.num_debian_vms) : "gcloud compute ssh ${i}"]
}

# output "ssh_c" {
#   value = [for i in range(var.num_vms) : "gcloud compute ssh --zone ${google_compute_instance.vmc[i].zone} ${google_compute_instance.vmc[i].name} --project ${data.google_project.my_proj.project_id}"]
# }
# gcloud compute ssh --zone "europe-west4-a" "vma-0" --project "meteo-376317"