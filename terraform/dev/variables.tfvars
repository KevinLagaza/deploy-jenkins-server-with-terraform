aws_region       = "us-east-1"
project_name     = "deploy-jenkins-project"
instance_type    = "m7i-flex.large"
instance_name = "jenkins-server"
root_volume_size = 30
ebs_volume_size  = 100

common_tags = {
  Environment = "dev"
  Project     = "deploy-jenkins-project"
  ManagedBy   = "terraform"
}