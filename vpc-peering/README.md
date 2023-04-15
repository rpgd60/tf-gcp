Simple tests of Terraform on GCP 

- Creates VPC,  Subnets and Compute Engine VMs
- Creates resources on  two regions, thus using provider alias
    - One of the subnets contains secondary ranges 
- Authentication with  `gcloud auth application-default login`

- Uses 'arm64' machine types (and images) since there is a free trial at the time of this writing (Q2 2023)


Not too relevant stuff  below - some useful gcloud  or tf commands


Command to create machine image:
gcloud compute machine-images create web-image-arm --source-instance=vm1-0 --source-instance-zone=europe-west4-a

Destroy machine images:
gcloud compute machine-images delete web-image-arm debian-11-nginx-arm



To re-create the VMs
terraform apply  -replace="google_compute_instance.vm1[0]" -replace="google_compute_instance.vm1[1]" -replace="google_compute_instance.vm2[0]"  -replace="google_compute_instance.vm2[1]"

