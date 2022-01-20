output "alb_dns_name" {
        value = "${module.myapp-alb.my_alb_dns_name}"

}


output "webserver_ips" {
        value = "${module.myapp-webserver.ec2_public_ip}"

}
