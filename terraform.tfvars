vpc_cidr_block =  "10.0.0.0/16"
subnet_cidr_block = [ "10.0.9.0/24", "10.0.10.0/24"] 
avil_zone = [ "ap-south-1a", "ap-south-1a" ]
env_prefix = "dev"
my_ip = "0.0.0.0/0"
instance_type = "t2.micro"
key_pair = "server-key"
my_private_ip = "10.0.9.211"
public_key_location = "/home/patmat/.ssh/id_rsa.pub"
private_key_location = "/home/patmat/.ssh/id_rsa"
image_name = "amzn2-ami-kernel-5.10-hvm*x86_64-gp2"


##ALB variables
alb_name = "NodeJS-ALB"
internal_alb = "false"
idle_timeout = "60"
load_balancer_type = "application"


