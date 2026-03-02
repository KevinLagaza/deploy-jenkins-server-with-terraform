provider "aws" {
  region                   = var.aws_region
  shared_credentials_files = ["../../.secrets/credentials"]
  profile                  = "dev"
}

terraform {
  backend "s3" {
    region                   = "us-east-1"
    encrypt                  = true
    use_lockfile             = true
    shared_credentials_files = ["../../.secrets/credentials"]
    profile                  = "dev"
    bucket                   = "terraform-backend-tp5-kevin"
    key                      = "eazy-tp5-dev.tfstate"
  }
}

# Module Key Pair
module "keypair" {
  source = "../modules/key_pair"

  key_name = "${var.project_name}-key"

  tags = var.common_tags
}


# Module Security Group
module "security_group" {
  source = "../modules/sg"

  sg_name        = "${var.project_name}-sg"
  sg_description = "Security group for ${var.project_name}"
  vpc_id         = var.vpc_id

  ingress_rules = var.ingress_rules

  tags = var.common_tags
}

# Module EC2
module "ec2" {
    
  source     = "../modules/ec2"
  depends_on = [module.security_group]
 instance_name = var.instance_name
  instance_type      = var.instance_type
  security_group_ids = [module.security_group.security_group_id]

  root_volume_size = var.root_volume_size
  ebs_volume_size  = var.ebs_volume_size

  user_data = file("${path.module}/user_data.sh")

  tags = var.common_tags
}

# Module EIP
module "eip" {
  source     = "../modules/eip"
  depends_on = [module.ec2]

  ec2_user         = var.ec2_user
  private_key_path = module.keypair.private_key_path
  eip_name         = "${var.project_name}-eip"
  instance_id      = module.ec2.instance_id

  tags = var.common_tags
}

# Elastic IP
module "ebs" {
  source            = "../modules/ebs"
  depends_on        = [module.ec2]
  availability_zone = var.availability_zone

  ebs_volume_size              = var.ebs_volume_size
  ebs_volume_type              = var.ebs_volume_type
  tags = merge(
    var.tags,
    {
      Name = "${var.instance_name}-ebs"
    }
  )
}

# Volume attachement
resource "aws_volume_attachment" "this" {
  depends_on  = [module.ebs]
  device_name = var.ebs_device_name

  volume_id   = module.ebs.volume_id
  instance_id = module.ec2.instance_id
}

# Attacher l'EIP à l'instance
resource "aws_eip_association" "this" {
  depends_on    = [module.eip]
  instance_id   = module.ec2.instance_id
  allocation_id = module.eip.allocation_id
}

# Enregistrer l'IP publique et l'adresse du serveur dans un fichier local
resource "local_sensitive_file" "ip_ec2" {
  depends_on = [aws_eip_association.this]

  content  = "${module.eip.public_ip}, ${module.eip.public_dns}"
  filename = "${path.root}/ip_ec2.txt"
}

