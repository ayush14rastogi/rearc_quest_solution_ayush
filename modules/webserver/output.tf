output "ec2_public_ip" {
#        value =  aws_instance.myapp-server.public_ip
	value = "${join(", ", aws_instance.myapp-server.*.public_ip)}"

}

output "ec2_instance_id" {
#        value =  aws_instance.myapp-server.private_ip
        value = "${join(", ", aws_instance.myapp-server.*.id)}"
}

