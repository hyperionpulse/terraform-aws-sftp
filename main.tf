resource "aws_vpc" "sftp_vpc" {
  cidr_block       = ""
  instance_tenancy = "default"
}

resource "aws_security_group" "sftp_sg" {
  name_prefix = "sftp_security_group"
  vpc_id = aws_vpc.sftp_vpc

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    # use your cidr blocks
    cidr_blocks      = [""] 
    ipv6_cidr_blocks = ["::/0"]
  }
}

resource "aws_subnet" "sftp_subnet" {
  vpc_id            = aws_vpc.sftp_vpc
  # utilize your own cidr block
  cidr_block        = ""
  availability_zone = var.region
}

resource "aws_key_pair" "key" {
  key_name   = "sftp-key"
  public_key = "" 
  # generate using ssh key-gen rsa
}

resource "aws_instance" "web" {
  ami           = var.instance_ami
  instance_type = var.instance_type
  subnet_id     = aws_subnet.sftp_subnet
  security_groups =  aws_security_group.sftp_sg
  key_name = aws_key_pair.key
  tags = {
    Name = var.ec2_name
  }

  root_block_device {
    volume_type = var.ebs_volume_type
    volume_size = var.ebs_volume_size
  }

  connection {
      type        = "ssh"
      user        = "root"  # Update based on the AMI's default user
      private_key = file("~/{$username}/.ssh/id_rsa") 
      host        = self.public_ip
  }

  provisioner "file" {
    source = "./variables.tf"
    destination = "/scripts/script.sh"
  }
}

