/*
#output "ayush-webserser-id" {
#        value = "${module.myapp-webserver.ec2_instance_id}"
#
#}

#output "ayush-subnet" {
#        value = "${module.myapp-subnet.subnet_id}"
#
#}


#output "ayush-subnet_ips" {
#        value = "${module.myapp-subnet.subnet_ips}"
#
#}

#output "myvpc_ip" {
#	value = "${module.myapp-subnet.vpc_id}"
#}
*/
## to fetch ec2 public ip
output "webserver_ips" {
        value = "${module.myapp-webserver.ec2_public_ip}"

}
