data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# need to configure
resource "aws_security_group" "sftp_sg" {
  name_prefix = "sftp-"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"


  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y openssh-server",
      "sudo mkdir -p /sftpusers",
      "sudo chown root:root /sftpusers",
      "sudo chmod 755 /sftpusers",
      "echo 'Match User sftpuser' | sudo tee -a /etc/ssh/sshd_config",
      "echo 'ChrootDirectory /sftpusers/%u' | sudo tee -a /etc/ssh/sshd_config",
      "echo 'ForceCommand internal-sftp' | sudo tee -a /etc/ssh/sshd_config",
      "echo 'AllowTcpForwarding no' | sudo tee -a /etc/ssh/sshd_config",
      "echo 'X11Forwarding no' | sudo tee -a /etc/ssh/sshd_config",
      "sudo systemctl restart sshd"
    ]

    connection {
      type        = "ssh"
      user        = "ubuntu"  # Update based on the AMI's default user
      private_key = file("~/.ssh/id_rsa") # need to figure out this ssh part
      host        = self.public_ip
    }
  }

  tags = {
    Name = "HelloWorld"
  }
}

