Command to create machine image:
gcloud compute machine-images create web-image-arm --source-instance=vm1-0 --source-instance-zone=europe-west4-a

Destroy machine images:
gcloud compute machine-images delete web-image-arm debian-11-nginx-arm



To re-create the VMs
terraform apply  -replace="google_compute_instance.vm1[0]" -replace="google_compute_instance.vm1[1]" -replace="google_compute_instance.vm2[0]"  -replace="google_compute_instance.vm2[1]"

