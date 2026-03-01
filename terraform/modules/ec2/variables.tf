variable "instance_name" {
  description = "Name of the EC2 instance"
  type        = string
#   default     = "ec2"
}

variable "availability_zone" {
  description = "availability zone for ec2"
  type        = string
  default     = "us-east-1b"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "security_group_ids" {
  description = "List of security group IDs"
  type        = list(string)
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

variable "ebs_volume_size" {
  description = "Size of the additional EBS volume in GB"
  type        = number
  default     = 50
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

variable "connection_type" {
  description = "Type of connection to ec2 instance"
  type        = string
  default = "ssh"
}

variable "user_data" {
  type        = string
  description = "User data script (cloud-init) fourni par le parent"
  default     = ""
}

variable "ubuntu_version" {
  type        = string
  description = "Version of ubuntu to be used"
  default     = "jammy"
}
