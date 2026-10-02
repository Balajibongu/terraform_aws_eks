module "vpc"{
    source= "git::https://github.com/pattasai123/terraform-vpc.git"

    #VPC
    vpc_cidr=local.vpc_cidr
    project_name=local.project_name
    env_name=local.env
    user_tags=local.tags

    #public subnets
    public_subnet_cidr=local.public_subnet

    #private subnets
    private_subnet_cidr=local.private_subnet

    #database subnets
    database_subnet_cidr=local.database_subnet
}

/*
data "aws_availability_zones" "available" {
  state = "available"
}
*/