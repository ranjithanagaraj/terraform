provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "ap-south-1"
}

resource "aws_instance" "web" {
  ami = "${var.ami}"
  instance_type = "t2.micro"
  key_name = "${var.key_name}"
  tags {
    Name = "Terraform3"
  }
  associate_public_ip_address = "true"

    provisioner "file" {
    source      = "docker-compose.yml"
    destination = "docker-compose.yml"
  }
    connection {
    type     = "ssh"
    user     = "ubuntu"
    private_key = "${file("pair1.pem")}"
  }
  }

  resource "aws_security_group" "allow_all" {
  name        = "allow-all-sg3"
  vpc_id      = "vpc-082b50fbd323ec349"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
        cidr_blocks     = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
}

