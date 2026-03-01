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

variable "availability_zone" {
  description = "availability zone for ec2"
  type        = string
  default     = "us-east-1b"
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}