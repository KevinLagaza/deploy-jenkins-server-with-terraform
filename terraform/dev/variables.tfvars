aws_region       = "us-east-1"
project_name     = "collective-terraform-project"
instance_type    = "t3.micro"
instance_name = "nginx-server"
root_volume_size = 30
ebs_volume_size  = 100

common_tags = {
  Environment = "dev"
  Project     = "collective-project"
  ManagedBy   = "terraform"
}