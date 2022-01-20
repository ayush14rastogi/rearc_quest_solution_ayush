variable vpc_cidr_block {}
 
variable subnet_cidr_block {
	description = "Subnet CIDR"
	type = list(string)
	
}
variable avil_zone {
        description = "AZ list"
        type = list(string)
}
variable env_prefix {}
