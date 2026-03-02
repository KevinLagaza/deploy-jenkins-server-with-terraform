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


### 4) Resource verification

After connecting to the AWS console, we can now see the resources that are supposed to be created.
- EC2 instance

**![EC2 instance](./terraform/imgs/ec2-instance.png)**

- Key Pair

**![EIP](./terraform/imgs/key-pair.png)**

- Securtity Group

**![EC2 instance](./terraform/imgs/sg.png)**

**![EC2 instance](./terraform/imgs/sg-attached-to-ec2.png)**

- Elastic IP

**![EIP](./terraform/imgs/eip.png)**

- Elastic Block Store

**![EBS](./terraform/imgs/ebs.png)**

- Local files (.txt and .pem files)

**![Local files](./terraform/imgs/local-files.png)**

### 5) Testing the Jenkins installation

- Connect to the ec2 instance.
- Run `docker exec jenkins cat /var/jenkins_home/secrets/initialAdminPassword`.
- Copy the password and paste it onto the jenkins starting interface.

**![Jenkins Start](./terraform/imgs/jenkins-start.png)**

**![Jenkins Complete](./terraform/imgs/jenkins-complete.png)**

**![Jenkins Ready](./terraform/imgs/jenkins-ready.png)**

### 6) Destroy all the resources previously created

- `terraform destroy`

We can now destroy the resources in order not to get billed unknowingly.

**![Terraform destroy](./terraform/imgs/terraform-destroy.png)**

