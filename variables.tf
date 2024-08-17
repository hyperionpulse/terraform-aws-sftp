variable "instance_ami" {
    default = "ami-0ae8f15ae66fe8cda"
    # AWS's Default Catalog AMI
}

variable "instance_type" {
    default = "m1.xlarge"
}

variable "region" {
    default = "us-east-1"
}

variable "ebs_volume_size" {
    default = 8
  
}

variable "ec2_name" {
    default = "sftp-ec2-terraform"
}