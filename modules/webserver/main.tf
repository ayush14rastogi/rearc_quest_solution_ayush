resource "aws_key_pair" "ssh-key" {
	key_name = "server-key"
	public_key = file(var.public_key_location)
}

resource "aws_security_group" "myapp-sg" {
  name        = "myapp-sg "
  description = "security group for websers"
  vpc_id     =  var.vpc_id

##SSH
  ingress {
    description      = "SSH from My ip"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = [var.my_ip]
  }

##ICMP
  ingress {
    description      = "ICMP from My ip"
    from_port        = 8
    to_port          = 0
    protocol         = "icmp"
    cidr_blocks      = [var.my_ip]
  }


# HTTP

 ingress {
    description      = "Web from internet"
    from_port        = 80
    to_port          = 80
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
    Name = "${var.env_prefix}-sg"

  }
}

data "aws_ami" "latest-amazon-linux-image" {
  most_recent = true
  owners = ["137112412989"]

  filter {
        name = "name"
        values = [var.image_name]
        }

  filter {
        name   = "virtualization-type"
        values = ["hvm"]
  }
}



resource "aws_instance" "myapp-server" {
  count = "${var.instance_count}"
  ami = data.aws_ami.latest-amazon-linux-image.id
  instance_type = var.instance_type

  subnet_id   = "${element(var.subnet_id, count.index)}"
  vpc_security_group_ids =  [aws_security_group.myapp-sg.id]
  private_ip = var.my_private_ip 

  associate_public_ip_address =  true
  key_name = aws_key_pair.ssh-key.key_name
  

  provisioner "file" {
    source      = "Dockerfile"
    destination = "/tmp/Dockerfile"
  

    connection {
      type     = "ssh"
      user     = "ec2-user"
      private_key = file(var.private_key_location)
      host     = self.public_ip

  }
}

  user_data =  file("amazon_enter-script.sh")

  tags =  {
	Name = "${var.env_prefix}-server-${count.index +1}"
	}

}



