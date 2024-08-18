# Terraform AWS SFTP Module

## Overview

This Terraform module provisions a basic AWS infrastructure for hosting an SFTP server on an EC2 instance. It creates a VPC, a subnet, a security group, an EC2 instance, and handles the initial provisioning.

## Requirements
  
| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 5.0 |

## Inputs

| Name                | Description                                             | Type   | Default                          | Example                            |
|---------------------|---------------------------------------------------------|--------|----------------------------------|------------------------------------|
| `cidr_block`        | The CIDR block for the VPC.                            | string | n/a                              | `10.0.0.0/16`                      |
| `subnet_cidr_block` | The CIDR block for the subnet.                         | string | n/a                              | `10.0.1.0/24`                      |
| `instance_ami`      | The AMI ID for the EC2 instance.                       | string | `ami-0ae8f15ae66fe8cda`           | `ami-0c55b159cbfafe1f0`            |
| `instance_type`     | The instance type for the EC2 instance.                | string | `m1.xlarge`                       | `t2.micro`                         |
| `region`            | The AWS region where the resources will be created.    | string | `us-east-1`                       | `us-east-1`                        |
| `ebs_volume_size`   | The size of the root EBS volume in GB.                 | number | `8`                              | `8`                                |
| `ec2_name`          | The tag name for the EC2 instance.                     | string | `sftp-ec2-terraform`              | `sftp-server`                      |
| `public_key`        | The SSH public key for accessing the EC2 instance.     | string | n/a                              | `file("~/.ssh/id_rsa.pub")`        |
| `username`          | The username for SSH connection.                       | string | n/a                              | `myuser`                           |

## Outputs

| Name          | Description                                      | Type   |
|---------------|--------------------------------------------------|--------|
| `instance_ip` | The public IP address of the EC2 instance.      | string |

## Used Resources

- **AWS VPC**: Creates a Virtual Private Cloud with a specified CIDR block.
- **AWS Subnet**: Creates a subnet within the VPC using the provided CIDR block.
- **AWS Security Group**: Creates a security group allowing all outbound traffic and IPv6 traffic.
- **AWS Key Pair**: Creates an EC2 key pair for SSH access.
- **AWS EC2 Instance**: Launches an EC2 instance within the subnet with specified AMI, instance type, and root EBS volume size. The instance is configured to use the provided SSH key for access.
- **Provisioner**: Copies a local file to the EC2 instance for initial setup.

## Usage

To use this module, create a new Terraform configuration file and include the module with the required variables. Here is an example:
```hcl
module "sftp_server" {
  source = "terraform-aws-sftp"

  cidr_block        = "10.0.0.0/16"
  subnet_cidr_block = "10.0.1.0/24"
  instance_ami      = "ami-0c55b159cbfafe1f0"
  instance_type     = "t2.micro"
  region            = "us-east-1"
  ebs_volume_size   = 8
  ec2_name          = "sftp-server"
  public_key        = file("~/.ssh/id_rsa.pub")
  username          = "myuser"
}

output "sftp_server_ip" {
  value = module.sftp_server.instance_ip
}
```

## Notes

- Update the `root` user in the `connection` block to match the default user for your AMI.
- Adjust the `source` path in the `provisioner "file"` block to point to your local script.
- Ensure the `public_key` variable is set to a valid SSH public key for accessing the EC2 instance.


## Authors

Module is maintained by [Reuben D'Souza](https://github.com/reubenjds) and [Ashan Praba](https://github.com/apraba05).

## License

MIT License. See [LICENSE](https://github.com/hyperionpulse/terraform-aws-sftp/blob/main/LICENSE) for full details.

