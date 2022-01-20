provider "aws" {
	region= "ap-south-1"

}


module "myapp-subnet" {
	source			= "./modules/subnet"
	vpc_cidr_block		=  var.vpc_cidr_block
	subnet_cidr_block	= var.subnet_cidr_block
	avil_zone		= var.avil_zone
	env_prefix		= var.env_prefix

}

module "myapp-webserver" {
        source  		= "./modules/webserver"
        avil_zone	 	= var.avil_zone
        env_prefix 		= var.env_prefix
        my_ip 			= var.my_ip
        instance_type 		= var.instance_type
        my_private_ip 		= var.my_private_ip
	public_key_location 	= var.public_key_location
	private_key_location 	= var.private_key_location
	image_name 		= var.image_name
	instance_count		= var.instance_count
	subnet_id 		= "${module.myapp-subnet.subnet_id}"
	vpc_id			= "${module.myapp-subnet.vpc_id}"             
}

module "myapp-alb" {
        source                  = "./modules/alb"
	alb_name		= var.alb_name
        env_prefix              = var.env_prefix
	internal_alb		= var.internal_alb
	load_balancer_type	= var.load_balancer_type
	idle_timeout		= var.idle_timeout
        subnet_cidr_block 	= var.subnet_cidr_block
        subnet_id               = "${module.myapp-subnet.subnet_id}"
        vpc_id                  = "${module.myapp-subnet.vpc_id}"
	instace_id		= "${module.myapp-webserver.ec2_instance_id}"

}

