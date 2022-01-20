variable instance_count {}
variable vpc_id {}
variable env_prefix {}
variable my_ip {}
variable instance_type {}
variable my_private_ip {}
variable public_key_location {}
variable private_key_location {}
variable image_name {}
variable subnet_id {
        type = list(string)
}
variable avil_zone {
        description = "AZ list"
        type = list(string)
}

