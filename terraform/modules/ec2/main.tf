data "aws_ami" "ubuntu_bionic" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu-pro-server/images/hvm-ssd/ubuntu-${var.ubuntu_version}-*"] 
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

}

resource "aws_instance" "this" {
  ami                    = data.aws_ami.ubuntu_bionic.id
  instance_type          = var.instance_type
  availability_zone = var.availability_zone
  vpc_security_group_ids = var.security_group_ids

  root_block_device {
    volume_size           = var.root_volume_size
    volume_type           = var.root_volume_type
    delete_on_termination = true
  }

    user_data = var.user_data != "" ? var.user_data : null

  tags = merge(
    var.tags,
    {
      Name = var.instance_name
    }
  )

}
