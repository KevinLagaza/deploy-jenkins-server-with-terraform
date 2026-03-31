# 🚀 Deploy Jenkins Server with Terraform

Automated and reproducible deployment of a Jenkins server on AWS infrastructure using Terraform modules.

---

## 📋 Table of Contents

- [Overview](#-overview)
- [Architecture](#-architecture)
- [Prerequisites](#-prerequisites)
- [Project Structure](#-project-structure)
- [Installation](#-installation)
  - [Step 1: Initialize Terraform](#step-1-initialize-terraform)
  - [Step 2: Validate Configuration](#step-2-validate-configuration)
  - [Step 3: Provision Resources](#step-3-provision-resources)
- [Verification](#-verification)
- [Accessing Jenkins](#-accessing-jenkins)
- [Cleanup](#-cleanup)
- [Troubleshooting](#-troubleshooting)

---

## 🎯 Overview

This project provides a set of Terraform modules to automate the deployment of a Jenkins server on AWS. The infrastructure is fully reproducible and exports relevant metadata to local files for easy access.

### ✨ Features

- 🖥️ **EC2 Instance** - Ubuntu-based Jenkins server
- 🔐 **SSH Key Pair** - Dynamically generated for secure access
- 🛡️ **Security Group** - Pre-configured firewall rules
- 🌐 **Elastic IP** - Static public IP address
- 💾 **EBS Volume** - Persistent storage for Jenkins data
- 📄 **Local Exports** - IP address and SSH key exported to local files

---

## 🏗️ Architecture
```
                         Internet
                            │
                            ▼
                    ┌───────────────┐
                    │  Elastic IP   │
                    │ (Public IP)   │
                    └───────────────┘
                            │
                            ▼
                    ┌───────────────┐
                    │Security Group │
                    │  Port 22/SSH  │
                    │ Port 8080/Web │
                    └───────────────┘
                            │
                            ▼
                    ┌───────────────┐
                    │ EC2 Instance  │
                    │   (Ubuntu)    │
                    │               │
                    │ ┌───────────┐ │
                    │ │  Docker   │ │
                    │ │ ┌───────┐ │ │
                    │ │ │Jenkins│ │ │
                    │ │ └───────┘ │ │
                    │ └───────────┘ │
                    └───────────────┘
                            │
                            ▼
                    ┌───────────────┐
                    │  EBS Volume   │
                    │ (Persistent)  │
                    └───────────────┘
```

---

## 🔧 Prerequisites

| Requirement | Description |
|-------------|-------------|
| Terraform | Latest version installed ([Download](https://www.terraform.io/downloads)) |
| AWS Account | Active account with appropriate permissions |
| S3 Bucket | For storing Terraform state file |
| AWS Credentials | Access Key ID and Secret Access Key |

### 🔐 AWS Credentials Setup

Create a credentials file with your AWS access keys:
```
~/.aws/credentials
```

or create a custom credentials file:
```ini
[dev]
aws_access_key_id = YOUR_ACCESS_KEY_ID
aws_secret_access_key = YOUR_SECRET_ACCESS_KEY
```

![AWS credentials](./terraform/imgs/aws-cred.png)

> ⚠️ **Security Note:** Never commit your credentials to version control!

---

## 📁 Project Structure
```
deploy-jenkins-server-with-terraform/
├── terraform/
│   ├── main.tf              # Main configuration
│   ├── variables.tf         # Variable definitions
│   ├── outputs.tf           # Output definitions
│   ├── terraform.tfvars     # Variable values
│   └── modules/
│       ├── ec2/             # EC2 instance module
│       │   ├── main.tf
│       │   ├── variables.tf
│       │   └── outputs.tf
│       ├── eip/             # Elastic IP module
│       │   ├── main.tf
│       │   ├── variables.tf
│       │   └── outputs.tf
│       ├── ebs/             # EBS volume module
│       │   ├── main.tf
│       │   ├── variables.tf
│       │   └── outputs.tf
│       ├── key_pair/        # SSH key pair module
│       │   ├── main.tf
│       │   ├── variables.tf
│       │   └── outputs.tf
│       └── sg/              # Security group module
│           ├── main.tf
│           ├── variables.tf
│           └── outputs.tf
├── imgs/                    # Documentation images
└── README.md
```

---

## 🚀 Installation

### Step 1: Initialize Terraform

Clone the repository and initialize Terraform:
```bash
git clone https://github.com/your-username/deploy-jenkins-server-with-terraform.git
cd deploy-jenkins-server-with-terraform/terraform
terraform init
```

![Terraform init](./terraform/imgs/terraform-init.png)

✅ **Expected result:** Plugins and modules installed, backend initialized.

---

### Step 2: Validate Configuration

Check for syntax errors and preview the execution plan:
```bash
terraform plan
```

![Terraform plan](./terraform/imgs/terraform-plan.png)

✅ **Expected result:** No errors, list of resources to be created.

---

### Step 3: Provision Resources

Deploy the infrastructure:
```bash
terraform apply
```

Type `yes` when prompted to confirm.

![Terraform apply](./terraform/imgs/terraform-apply.png)

✅ **Expected result:** All resources created successfully.

---

## ✅ Verification

After deployment, verify the resources in the AWS Console:

### 🖥️ EC2 Instance

![EC2 instance](./terraform/imgs/ec2-instance.png)

### 🔑 Key Pair

![Key Pair](./terraform/imgs/key-pair.png)

### 🛡️ Security Group

![Security Group](./terraform/imgs/sg.png)

![Security Group attached to EC2](./terraform/imgs/sg-attached-to-ec2.png)

### 🌐 Elastic IP

![EIP](./terraform/imgs/eip.png)

### 💾 Elastic Block Store

![EBS](./terraform/imgs/ebs.png)

### 📄 Local Files Generated

| File | Description |
|------|-------------|
| `ip_ec2.txt` | Public IP address of the Jenkins server |
| `jenkins-key.pem` | SSH private key for EC2 access |

![Local files](./terraform/imgs/local-files.png)

---

## 🔓 Accessing Jenkins

### Step 1: Connect to EC2 Instance
```bash
ssh -i jenkins-key.pem ubuntu@$(cat ip_ec2.txt)
```

### Step 2: Get Jenkins Initial Password
```bash
docker exec jenkins cat /var/jenkins_home/secrets/initialAdminPassword
```

<<<<<<< HEAD
### Step 3: Access Jenkins Web Interface
=======
**NB:** Do not forget to detach and delete the volume.

We can now destroy the resources in order not to get billed unknowingly.
>>>>>>> 759119f97577b00783a417be31d3d3cfbee4e4da

Open your browser and navigate to:
```
http://<ELASTIC_IP>:8080
```

### Step 4: Complete Setup

1. Paste the initial admin password

   ![Jenkins Start](./terraform/imgs/jenkins-start.png)

2. Install suggested plugins

   ![Jenkins Complete](./terraform/imgs/jenkins-complete.png)

3. Create admin user and start using Jenkins

   ![Jenkins Ready](./terraform/imgs/jenkins-ready.png)

✅ **Jenkins is now ready to use!**

---

## 🧹 Cleanup

To avoid unexpected AWS charges, destroy all resources when done:
```bash
terraform destroy
```

Type `yes` when prompted to confirm.

![Terraform destroy](./terraform/imgs/terraform-destroy.png)

> ⚠️ **Warning:** This will permanently delete all created resources including data stored on EBS volumes.

---

## 🛠️ Troubleshooting

| Issue | Solution |
|-------|----------|
| `terraform init` fails | Check internet connection and AWS credentials |
| `terraform apply` timeout | Verify AWS region and availability |
| Cannot SSH to EC2 | Check security group rules and key pair permissions |
| Jenkins not accessible | Verify port 8080 is open in security group |
| Docker not running | Check user data script execution logs |

### Useful Commands
```bash
# Check Terraform state
terraform state list

# View specific resource
terraform state show module.ec2.aws_instance.this

# View outputs
terraform output

# Force recreation of a resource
terraform taint module.ec2.aws_instance.this
terraform apply
```

### Debug EC2 User Data
```bash
# Connect to EC2 and check cloud-init logs
ssh -i jenkins-key.pem ubuntu@<ELASTIC_IP>
sudo cat /var/log/cloud-init-output.log
```

---

## 📊 Terraform Modules

| Module | Description |
|--------|-------------|
| `ec2` | Creates Ubuntu EC2 instance with Docker and Jenkins |
| `eip` | Allocates and associates Elastic IP |
| `ebs` | Creates and attaches persistent storage |
| `key_pair` | Generates SSH key pair dynamically |
| `sg` | Configures security group with required rules |

---

## 📚 Resources

- [Terraform AWS Provider Documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [Jenkins Documentation](https://www.jenkins.io/doc/)
- [AWS EC2 User Guide](https://docs.aws.amazon.com/ec2/)

---

## 👨‍💻 Author

**Kevin Lagaza**

---

## 📄 License

This project is licensed under the MIT License.