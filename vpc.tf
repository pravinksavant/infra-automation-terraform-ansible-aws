module "vpc" {

source="terraform-aws-modules/vpc/aws"

name = var.VPC_NAME
cidr = var.VPC_CIDR
azs = [var.ZONE1, var.ZONE2, var.ZONE3]
private_subnets = [var.PRIVSUB1_CIDR, var.PRIVSUB2_CIDR, var.PRIVSUB3_CIDR]
public_subnets = [var.PUBSUB1_CIDR, var.PUBSUB2_CIDR, var.PUBSUB3_CIDR]

enable_nat_gateway = true
single_nat_gateway = true
enable_dns_hostnames = true
enable_dns_support = true

tags={
Terraform = true
Env = "Dev"
}


}
