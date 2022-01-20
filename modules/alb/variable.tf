variable vpc_id {}
variable instace_id {}
variable alb_name {}
variable internal_alb{} 
variable idle_timeout {}
variable load_balancer_type {}
variable subnet_id {
        type = list(string)
}

variable subnet_cidr_block {
	description = "Subnet CIDR"
	type = list(string)
	
}
variable env_prefix {}
