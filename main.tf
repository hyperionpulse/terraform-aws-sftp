resource "aws_vpc" "sftp_vpc" {
  cidr_block       = var.cidr_block
  instance_tenancy = "default"
}

resource "aws_security_group" "sftp_sg" {
  name_prefix = var.sg_name_prefix
  vpc_id      = aws_vpc.sftp_vpc.id

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    # use your cidr blocks
    cidr_blocks = var.cidr_blocks_ipv4
    # ipv6_cidr_blocks = ["::/0"]
    # optional you can either use IPv4 or IPv6 CIDR Blocks
  }
}

resource "aws_subnet" "sftp_subnet" {
  vpc_id = aws_vpc.sftp_vpc.id
  # utilize your own cidr block
  cidr_block        = var.cidr_block
  availability_zone = var.region
}

resource "aws_key_pair" "key" {
  key_name   = var.key_name
  public_key = ""
  # generate a public key and this key will be the only key users can utilize to SSH into the instance
}

resource "aws_instance" "sftp_ec2_server" {
  ami             = var.instance_ami
  instance_type   = var.instance_type
  subnet_id       = aws_subnet.sftp_subnet.id
  key_name        = aws_key_pair.key.key_name
  vpc_security_group_ids = [aws_security_group.sftp_sg.id]  # Use security_group_ids with the ID of the security group
  
  tags = {
    Name = var.ec2_name
  }

  root_block_device {
    volume_type = var.ebs_volume_type
    volume_size = var.ebs_volume_size
  }

  connection {
    type        = "ssh"
    user        = var.linux_user # Update based on the AMI's default user
    private_key = file("~/${var.linux_user}/.ssh/id_rsa")
    host        = self.public_ip
  }

  provisioner "file" {
    source      = "./variables.tf"
    destination = var.remote_directory
  }
}
