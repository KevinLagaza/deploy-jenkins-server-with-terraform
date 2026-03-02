variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "instance_name" {
  description = "Name of the instance"
  type        = string
  default = "Jenkins-server-dev"
}

variable "project_name" {
  description = "Name of the project"
  type        = string
  default     = "deploy-jenkins-project-dev"
}

variable "vpc_id" {
  description = "VPC ID (leave null for default VPC)"
  type        = string
  default     = null
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "m7i-flex.large"
}

variable "ebs_volume_size" {
  description = "Size of the additional EBS volume in GB"
  type        = number
  default     = 50
}

variable "ingress_rules" {
  description = "List of ingress rules for security group"
  type = list(object({
    description = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  default = [
    {
      description = "Jenkins"
      from_port   = 8080
      to_port     = 8080
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      description = "Jenkins Agent"
      from_port   = 50000
      to_port     = 50000
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      description = "HTTP"
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      description = "HTTPS"
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      description = "SSH"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}

variable "ec2_user" {
  description = "User of ec2 instance"
  type        = string
  default     = "ubuntu"
}

variable "private_key_path" {
  description = "Path to the private SSH key file"
  type        = string
  default     = "../../.secrets/deploy_app_dev.pem"
}

variable "common_tags" {
  description = "Common tags to apply to all resources"
  type        = map(string)
  default = {
    Environment = "dev"
    ManagedBy   = "terraform"
  }
}

variable "root_volume_size" {
  description = "Size of the root volume in GB"
  type        = number
  default     = 20
}

variable "root_volume_type" {
  description = "Type of the root volume"
  type        = string
  default     = "gp3"
}

variable "ebs_volume_type" {
  description = "Type of the additional EBS volume"
  type        = string
  default     = "gp3"
}

variable "ebs_device_name" {
  description = "Device name for the EBS volume"
  type        = string
  default     = "/dev/sdf"
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}

variable "availability_zone" {
  description = "availability zone for ec2"
  type        = string
  default     = "us-east-1b"
}

variable "ubuntu_version" {
  description = "Ubuntu version to be used"
  type        = string
  default     = "jammy"
}