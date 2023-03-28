module "network" {
    source = "../modules/network"

    project = "solashi-avalanche"
    availability_zone = "us-east-2a"
    vpc_cidr_block = "10.0.0.0/16"
    public_subnet_cidr_block = "10.0.1.0/24"
}

module "node" {
    source = "../modules/node"

    project = "solashi-avalanche"
    instance_type = "c5.2xlarge"
    subnet_public_id = module.network.public_subnet_id
    public_security_group_id = module.network.public_security_group_id
}