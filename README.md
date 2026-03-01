# deploy-jenkins-server-with-terraform

## Getting started

The objective of this project is to design a **Continuous Integration (CI)** and **Continuous Deployment (CD)** pipeline for deploying a  [Spring Boot application](https://github.com/eazytraining/PayMyBuddy) on AWS.


## Prerequisites

- Install terraform on your laptop.
- Create an AWS account if not done yet. Create a bucket that will contain the **terraform state** file.
- Create a folder where you create the credentials' file that will contain the access and secret IDs. The file should look like this:

**![AWS credentials](./terraform/imgs/aws-cred.png)**

## Execution

After cloning the repository, do the following:

### 1) Intialize your terraform folder
The required plugins and modules will be installed
- `cd <terraform_folder_name>` 
- `terraform init`

### 2) Ensure there are no syntax errors

- `terraform plan`

### 3) Ensure there are no syntax errors

