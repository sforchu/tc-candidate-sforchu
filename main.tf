module "vpc" {
    source = "./vpc"
    
}

module "db" {
    source = "./dynamodb"
    
}

module "iam" {
    source = "./iam"
    
}

module "ec2"{
    source = "./ec2"
    subnet_ids = module.vpc.public_subnet_ids
    sg_id = module.vpc.sg_id
    iam_role_name = module.iam.iam_role_name
}

module "lb" {
    source = "./lb"
    lb_sg_id = module.vpc.lb_sg_id
    public_subnet_ids =  module.vpc.public_subnet_ids
    vpc_id = module.vpc.vpc_id
    instance_id = module.ec2.instance_id
}

