module "network" {
    source = "../modules/network"

    project = "dn-avalanche"
    availability_zone = "ap-southeast-1a"
    vpc_cidr_block = "10.0.0.0/16"
    public_subnet_cidr_block = "10.0.1.0/24"
}

module "node" {
    source = "../modules/node"

    project = "dn-avalanche"
    instance_type = "t2.micro"
    subnet_public_id = module.network.public_subnet_id
    public_security_group_id = module.network.public_security_group_id
}