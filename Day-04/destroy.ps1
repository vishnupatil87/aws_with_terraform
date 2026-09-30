terraform destroy --var-file=dev.tfvars --auto-approve
terraform workspace select  default
terraform workspace delete dev