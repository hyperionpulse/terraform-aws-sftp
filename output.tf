output "instance_ip" {
  value = aws_instance.sftp_ec2_server.public_ip
}
