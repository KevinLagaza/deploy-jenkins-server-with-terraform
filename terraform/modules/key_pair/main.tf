# Generate a private key RSA
resource "tls_private_key" "this" {
  algorithm = var.algorithm
  rsa_bits  = var.rsa_bits
}

resource "aws_key_pair" "this" {
  key_name   = var.key_name
  public_key = tls_private_key.this.public_key_openssh
    tags = merge(
    var.tags,
    {
      Name = var.key_name
    }
  )
}

# Save the key locally
resource "local_file" "private_key" {
  content         = tls_private_key.this.private_key_pem
  filename        = "${path.root}/${var.key_name}.pem"
  file_permission = "0400"
}