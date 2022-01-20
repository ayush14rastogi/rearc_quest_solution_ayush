output "alb_dns_name" {
        value = "${module.myapp-alb.alb_dns}"

}


output "webserver_ips" {
        value = "${module.myapp-webserver.ec2_public_ip}"

}
