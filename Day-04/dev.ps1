terraform init 
terraform workspace new dev 
terraform plan --var-file=dev.tfvars 
terraform apply --var-file=dev.tfvars --auto-approve