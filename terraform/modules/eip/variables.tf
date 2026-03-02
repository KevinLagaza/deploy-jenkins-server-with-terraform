variable "eip_name" {
  description = "Name tag for the Elastic IP"
  type        = string
}

variable "instance_id" {
  description = "ID of the EC2 instance to attach the EIP"
  type        = string
}

variable "tags" {
  description = "Tags to apply to the EIP"
  type        = map(string)
  default     = {}
}

variable "ec2_user" {
  description = "User of ec2 instance"
  type        = string
  default     = "ubuntu"
}

variable "private_key_path" {
  description = "Path to the private SSH key file"
  type        = string
}
