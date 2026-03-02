output "key_pair_name" {
  description = "Name of the key pair"
  value = aws_key_pair.this.key_name
}

output "key_pair_id" {
    description = "The ID of the key pair"
    value = aws_key_pair.this.key_pair_id
}

output "private_key_pem" {
  description = "Private key in PEM format"
  value       = tls_private_key.this.private_key_pem
  sensitive   = true
}

output "public_key_openssh" {
  description = "Public key in OpenSSH format"
  value       = tls_private_key.this.public_key_openssh
}

output "private_key_path" {
  description = "Path to the private key file"
  value       = local_file.private_key.filename
}