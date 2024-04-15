
#cd terraform
## 
#az login --scope https://graph.microsoft.com/.default


### check terraform version
#terraform version

### create terraform workspace
#terraform workspace new rhs  

#terraform workspace list

### initiate terraform
terraform init

### validate code
terraform validate

### plan
terraform plan -out=tfplan -var-file="examples/terraform.tfvars"

### plan destroy
#terraform plan -destroy -out=tfplan -var-file="var.tfvars"

### apply
terraform apply tfplan