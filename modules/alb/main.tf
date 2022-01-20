resource "aws_security_group" "myalb-sg" {
  name        = "myapp-sg-alb"
  description = "security group for alb"
  vpc_id     =  var.vpc_id

# HTTPS

 ingress {
    description      = "Web from internet"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
}
egress {
    from_port        = 0
    to_port          = 0

    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    prefix_list_ids  = []
  }

 tags = {
    Name = "${var.env_prefix}-sg-${var.alb_name}"

  }
}

resource "aws_alb" "alb" {  
  name            	= var.alb_name
#  subnets         	= [for subnet in var.subnet_id : subnet.id ]
  security_groups 	= [aws_security_group.myalb-sg.id]
  internal        	= var.internal_alb
  load_balancer_type	= var.load_balancer_type
  idle_timeout    	= var.idle_timeout


  subnet_mapping {
    subnet_id            = var.subnet_id[0]
  }

  subnet_mapping {
    subnet_id            = var.subnet_id[1]
  }


  tags= {    
    Name = "${var.env_prefix}-alb"
  }   
#  access_logs {    
#    bucket = "${var.s3_bucket}"    
#    prefix = "ELB-logs"  
#  }
}


resource "aws_alb_target_group" "alb_target_group" {
  name     = "myapp-tg-alb"
  port     = 80
  protocol = "HTTP"
  vpc_id     =  var.vpc_id

  # Alter the destination of the health check to be the login page.
  health_check {
    path = "/"
    port = 80
  }
}

resource "aws_iam_server_certificate" "https_cert" {
  name_prefix      = "https_cert"
  certificate_body = file("mycert/my-certificate.pem")
  private_key      = file("mycert/my-private-key.pem")

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_alb_listener" "https_listener" {  
  load_balancer_arn = aws_alb.alb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = aws_iam_server_certificate.https_cert.arn


  default_action {    
    target_group_arn = aws_alb_target_group.alb_target_group.arn
    type             = "forward"  
  }
}


resource "aws_lb_target_group_attachment" "aws_lb_attachment" {
  target_group_arn = aws_alb_target_group.alb_target_group.arn
  target_id        = var.instace_id
  port             = 80
}
