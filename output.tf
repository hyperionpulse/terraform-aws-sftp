output "instance_ip" {
  value = aws_instance.sftp_server.public_ip
}