variable "instance_ami" {
  type        = string
  default     = "ami-0ae8f15ae66fe8cda"
  description = "The AMI ID for the EC2 instance. Use AWS's Default Catalog AMI or specify a custom AMI ID."
}

variable "instance_type" {
  type        = string
  default     = "m1.xlarge"
  description = "The instance type for the EC2 instance. Choose an instance type that suits your workload."
}

variable "region" {
  type        = string
  default     = "us-east-1"
  description = "The AWS region where the resources will be created. Example: us-east-1."
}

variable "ebs_volume_size" {
  type        = number
  default     = 8
  description = "The size of the root EBS volume in GB."
}

variable "ebs_volume_type" {
  type        = string
  default     = "gp3"
  description = "The type of the root EBS volume. Example values: gp2, gp3, io1, io2, st1, sc1."
}

variable "ec2_name" {
  type        = string
  default     = ""
  description = "The tag name for the EC2 instance."
}

variable "sg_name_prefix" {
  type        = string
  default     = ""
  description = "The prefix name for the security group"
}

variable "remote_directory" {
  type        = string
  default     = ""
  description = "The remote directory as to where the script to create a user is configured."
}

variable "cidr_blocks_ipv4" {
  type = list(string)
  default = [ "" ]
  description = "The CIDR Blocks are stored to configure the security group."  
}

variable "cidr_block" {
  type = string
  default = ""
  description = "The CIDR Block used to configure the VPC and Subnet."
}

variable "key_name" {
  type = string
  default = ""
  description = "The key pair name of the EC2 instance." 
}

variable "linux_user" {
  type = string
  default = "root"
  description = "Username that will remotely enter the instance to configure settings." 
}
