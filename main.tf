provider "aws" {
    region = "eu-west-1"
    access_key = var.access_key_id
    secret_key = var.secret_access_key
}
 module "subnets" {
    source          = "./subnets"
    vpc_id          = module.vpc.vpc_id
    public_route_id = module.vpc.public_route_id
    private_route_id= module.vpc.private_route_id
	sec_web_id		= module.vpc.sec_ssh_id
	sec_jenkins_id  = module.vpc.sec_jenkins_id
	sec_ssh_id		= module.vpc.sec_ssh_id
	sec_internal_ssh_id = module.vpc.sec_internal_ssh_id
	sec_docker_swarm_id = module.vpc.sec_allow_docker_swarm_id
    internet_gate   = module.vpc.internet_gate
} 
module "vpc" {
    source          = "./vpc"
	nat_gateway		= module.subnets.nat_gateway
}

module "ec2" {
    source          = "./ec2"
    nic_bastian_id          = module.subnets.nic_bastian_id
    nic_jenkins_id          = module.subnets.nic_jenkins_id
	nic_manager_id			= module.subnets.nic_manager_id
	subnet_private_id			= module.subnets.private_subnet_id
	sec_docker_swarm_id     = module.vpc.sec_allow_docker_swarm_id
}

module "rds" {
	source			= "./rds"
	public_subnet_id		= module.subnets.public_subnet_id
	private_subnet_id		= module.subnets.private_subnet_id
}
