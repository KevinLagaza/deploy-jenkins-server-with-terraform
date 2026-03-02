output "public_ip" {
  description = "The Elastic IP address"
  value       = aws_eip.this.public_ip
}

output "allocation_id" {
  description = "Allocation ID of the Elastic IP"
  value       = aws_eip.this.allocation_id
}

output "public_dns" {
  description = "URL to access Jenkins"
  value       = aws_eip.this.public_dns
}