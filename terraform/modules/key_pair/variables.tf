variable "tags" {
  description = "Tags to apply to the key pair"
  type        = map(string)
  default     = {}
}

variable "key_name" {
    description = "Name of the key used for SSH connection to EC2"
  type        = string
  default     = "terraform-key"
  
}

variable "algorithm" {
  description = "Algorithm for the key (RSA or ED25519)"
  type        = string
  default     = "RSA"
}

variable "rsa_bits" {
  description = "Number of bits for RSA key"
  type        = number
  default     = 4096
}