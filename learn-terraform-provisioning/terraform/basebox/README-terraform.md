tonybooker@iMac27-Pro:$ terraform plan
Refreshing Terraform state in-memory prior to plan...
The refreshed state will be used to calculate this plan, but will not be
persisted to local or remote state storage.


------------------------------------------------------------------------

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # aws_instance.web will be created
  + resource "aws_instance" "web" {
      + ami                          = "ami-0d0d9e874d5835d68"
      + arn                          = (known after apply)
      + associate_public_ip_address  = true
      + availability_zone            = (known after apply)
      + cpu_core_count               = (known after apply)
      + cpu_threads_per_core         = (known after apply)
      + get_password_data            = false
      + host_id                      = (known after apply)
      + id                           = (known after apply)
      + instance_state               = (known after apply)
      + instance_type                = "t2.micro"
      + ipv6_address_count           = (known after apply)
      + ipv6_addresses               = (known after apply)
      + key_name                     = (known after apply)
      + outpost_arn                  = (known after apply)
      + password_data                = (known after apply)
      + placement_group              = (known after apply)
      + primary_network_interface_id = (known after apply)
      + private_dns                  = (known after apply)
      + private_ip                   = (known after apply)
      + public_dns                   = (known after apply)
      + public_ip                    = (known after apply)
      + secondary_private_ips        = (known after apply)
      + security_groups              = (known after apply)
      + source_dest_check            = true
      + subnet_id                    = (known after apply)
      + tags                         = {
          + "Name" = "packer-basebox-devsecops"
        }
      + tenancy                      = (known after apply)
      + volume_tags                  = (known after apply)
      + vpc_security_group_ids       = (known after apply)

      + ebs_block_device {
          + delete_on_termination = (known after apply)
          + device_name           = (known after apply)
          + encrypted             = (known after apply)
          + iops                  = (known after apply)
          + kms_key_id            = (known after apply)
          + snapshot_id           = (known after apply)
          + volume_id             = (known after apply)
          + volume_size           = (known after apply)
          + volume_type           = (known after apply)
        }

      + ephemeral_block_device {
          + device_name  = (known after apply)
          + no_device    = (known after apply)
          + virtual_name = (known after apply)
        }

      + metadata_options {
          + http_endpoint               = (known after apply)
          + http_put_response_hop_limit = (known after apply)
          + http_tokens                 = (known after apply)
        }

      + network_interface {
          + delete_on_termination = (known after apply)
          + device_index          = (known after apply)
          + network_interface_id  = (known after apply)
        }

      + root_block_device {
          + delete_on_termination = (known after apply)
          + device_name           = (known after apply)
          + encrypted             = (known after apply)
          + iops                  = (known after apply)
          + kms_key_id            = (known after apply)
          + volume_id             = (known after apply)
          + volume_size           = (known after apply)
          + volume_type           = (known after apply)
        }
    }

  # aws_internet_gateway.igw will be created
  + resource "aws_internet_gateway" "igw" {
      + arn      = (known after apply)
      + id       = (known after apply)
      + owner_id = (known after apply)
      + vpc_id   = (known after apply)
    }

  # aws_route_table.rtb_public will be created
  + resource "aws_route_table" "rtb_public" {
      + id               = (known after apply)
      + owner_id         = (known after apply)
      + propagating_vgws = (known after apply)
      + route            = [
          + {
              + cidr_block                = "0.0.0.0/0"
              + egress_only_gateway_id    = ""
              + gateway_id                = (known after apply)
              + instance_id               = ""
              + ipv6_cidr_block           = ""
              + local_gateway_id          = ""
              + nat_gateway_id            = ""
              + network_interface_id      = ""
              + transit_gateway_id        = ""
              + vpc_peering_connection_id = ""
            },
        ]
      + vpc_id           = (known after apply)
    }

  # aws_route_table_association.rta_subnet_public will be created
  + resource "aws_route_table_association" "rta_subnet_public" {
      + id             = (known after apply)
      + route_table_id = (known after apply)
      + subnet_id      = (known after apply)
    }

  # aws_security_group.sg_22_80 will be created
  + resource "aws_security_group" "sg_22_80" {
      + arn                    = (known after apply)
      + description            = "Managed by Terraform"
      + egress                 = [
          + {
              + cidr_blocks      = [
                  + "0.0.0.0/0",
                ]
              + description      = ""
              + from_port        = 0
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + protocol         = "-1"
              + security_groups  = []
              + self             = false
              + to_port          = 0
            },
        ]
      + id                     = (known after apply)
      + ingress                = [
          + {
              + cidr_blocks      = [
                  + "0.0.0.0/0",
                ]
              + description      = ""
              + from_port        = 22
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + protocol         = "tcp"
              + security_groups  = []
              + self             = false
              + to_port          = 22
            },
          + {
              + cidr_blocks      = [
                  + "0.0.0.0/0",
                ]
              + description      = ""
              + from_port        = 8080
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + protocol         = "tcp"
              + security_groups  = []
              + self             = false
              + to_port          = 8080
            },
          + {
              + cidr_blocks      = [
                  + "0.0.0.0/0",
                ]
              + description      = ""
              + from_port        = 80
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + protocol         = "tcp"
              + security_groups  = []
              + self             = false
              + to_port          = 80
            },
        ]
      + name                   = "sg_22"
      + owner_id               = (known after apply)
      + revoke_rules_on_delete = false
      + vpc_id                 = (known after apply)
    }

  # aws_subnet.subnet_public will be created
  + resource "aws_subnet" "subnet_public" {
      + arn                             = (known after apply)
      + assign_ipv6_address_on_creation = false
      + availability_zone               = (known after apply)
      + availability_zone_id            = (known after apply)
      + cidr_block                      = "10.1.0.0/24"
      + id                              = (known after apply)
      + ipv6_cidr_block_association_id  = (known after apply)
      + map_public_ip_on_launch         = false
      + owner_id                        = (known after apply)
      + vpc_id                          = (known after apply)
    }

  # aws_vpc.vpc will be created
  + resource "aws_vpc" "vpc" {
      + arn                              = (known after apply)
      + assign_generated_ipv6_cidr_block = false
      + cidr_block                       = "10.1.0.0/16"
      + default_network_acl_id           = (known after apply)
      + default_route_table_id           = (known after apply)
      + default_security_group_id        = (known after apply)
      + dhcp_options_id                  = (known after apply)
      + enable_classiclink               = (known after apply)
      + enable_classiclink_dns_support   = (known after apply)
      + enable_dns_hostnames             = true
      + enable_dns_support               = true
      + id                               = (known after apply)
      + instance_tenancy                 = "default"
      + ipv6_association_id              = (known after apply)
      + ipv6_cidr_block                  = (known after apply)
      + main_route_table_id              = (known after apply)
      + owner_id                         = (known after apply)
    }

Plan: 7 to add, 0 to change, 0 to destroy.

------------------------------------------------------------------------


tonybooker@iMac27-Pro:$ terraform apply -auto-approve
aws_vpc.vpc: Creating...
aws_vpc.vpc: Creation complete after 5s [id=vpc-07367f3f5a27b7ef7]
aws_internet_gateway.igw: Creating...
aws_subnet.subnet_public: Creating...
aws_security_group.sg_22_80: Creating...
aws_subnet.subnet_public: Creation complete after 2s [id=subnet-0508b701a686fb076]
aws_internet_gateway.igw: Creation complete after 2s [id=igw-08983593338d54c19]
aws_route_table.rtb_public: Creating...
aws_route_table.rtb_public: Creation complete after 2s [id=rtb-0a761f35f9ab365c4]
aws_route_table_association.rta_subnet_public: Creating...
aws_security_group.sg_22_80: Creation complete after 5s [id=sg-025f6078b774e92ce]
aws_instance.web: Creating...
aws_route_table_association.rta_subnet_public: Creation complete after 1s [id=rtbassoc-00cb992ab267b30f3]
aws_instance.web: Still creating... [10s elapsed]
aws_instance.web: Still creating... [20s elapsed]
aws_instance.web: Still creating... [30s elapsed]
aws_instance.web: Creation complete after 36s [id=i-0a6a9d5ec69eec663]

Apply complete! Resources: 7 added, 0 changed, 0 destroyed.

Outputs:

id = 52.12.125.59



tonybooker@iMac27-Pro:$ terraform destroy -auto-approve
aws_vpc.vpc: Refreshing state... [id=vpc-078dbf3607e692c03]
aws_internet_gateway.igw: Refreshing state... [id=igw-0c7f3a575c44a4c2d]
aws_subnet.subnet_public: Refreshing state... [id=subnet-0c19e9704fe5905e5]
aws_security_group.sg_22_80: Refreshing state... [id=sg-0ca852a7a99c53787]
aws_route_table.rtb_public: Refreshing state... [id=rtb-077f2326c7ebc4342]
aws_instance.web: Refreshing state... [id=i-0ccb2e6b02a466642]
aws_route_table_association.rta_subnet_public: Refreshing state... [id=rtbassoc-0c1640266c41c125c]
aws_route_table_association.rta_subnet_public: Destroying... [id=rtbassoc-0c1640266c41c125c]
aws_instance.web: Destroying... [id=i-0ccb2e6b02a466642]
aws_route_table_association.rta_subnet_public: Destruction complete after 0s
aws_route_table.rtb_public: Destroying... [id=rtb-077f2326c7ebc4342]
aws_route_table.rtb_public: Destruction complete after 2s
aws_internet_gateway.igw: Destroying... [id=igw-0c7f3a575c44a4c2d]
aws_instance.web: Still destroying... [id=i-0ccb2e6b02a466642, 10s elapsed]
aws_internet_gateway.igw: Still destroying... [id=igw-0c7f3a575c44a4c2d, 10s elapsed]
aws_instance.web: Still destroying... [id=i-0ccb2e6b02a466642, 20s elapsed]
aws_internet_gateway.igw: Still destroying... [id=igw-0c7f3a575c44a4c2d, 20s elapsed]
aws_internet_gateway.igw: Destruction complete after 22s
aws_instance.web: Still destroying... [id=i-0ccb2e6b02a466642, 30s elapsed]
aws_instance.web: Destruction complete after 31s
aws_subnet.subnet_public: Destroying... [id=subnet-0c19e9704fe5905e5]
aws_security_group.sg_22_80: Destroying... [id=sg-0ca852a7a99c53787]
aws_security_group.sg_22_80: Destruction complete after 1s
aws_subnet.subnet_public: Destruction complete after 1s
aws_vpc.vpc: Destroying... [id=vpc-078dbf3607e692c03]
aws_vpc.vpc: Destruction complete after 1s

Destroy complete! Resources: 7 destroyed.
