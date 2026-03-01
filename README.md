# deploy-jenkins-server-with-terraform

## Getting started

This project involves developing several Terraform modules to facilitate the automated and reproducible deployment of a Jenkins server on AWS infrastructure. Upon execution, the modules will export relevant metadata to a text file stored locally on the machine running Terraform.

## Prerequisites

- Install terraform on your laptop.
- Create an AWS account if not done yet. Create a bucket that will contain the **terraform state** file.
- Create a folder where you create the credentials' file that will contain the access and secret IDs. The file should look like this:

**![AWS credentials](./terraform/imgs/aws-cred.png)**

## Execution

After cloning the repository, do the following:

### 1) Intialize your terraform folder
The required plugins and modules will be installed as well as the initialization of the backend that will store the tfsate file.

- `cd <terraform_folder_name>` 
- `terraform init`

**![Terraform init](./terraform/imgs/terraform-init.png)**

### 2) Ensure there are no syntax errors

- `terraform plan`

**![Terraform plan](./terraform/imgs/terraform-plan.png)**

### 3) Provionning of resources

- `terraform apply`

**![Terraform apply](./terraform/imgs/terraform-apply.png)**

