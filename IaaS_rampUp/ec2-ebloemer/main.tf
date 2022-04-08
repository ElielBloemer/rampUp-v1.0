resource "aws_instance" "ec2-ebloemer" {
  count = var.ebc_amount
  #TODO  AMI ID en funcion de la region
  ami           = "ami-04505e74c0741db8d"
  instance_type = var.instance_type
  subnet_id = data.terraform_remote_state.vpc.outputs.public_subnet
  key_name = var.key_name
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]
  user_data = file("./IaaS_rampUp/scripts/ubuntu-setUp.sh")
  tags = {
    Name = "VM-EBloemer"
  }
}

resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"
  vpc_id      = data.terraform_remote_state.vpc.outputs.vpc_id

  ingress {
    description      = "SSH from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::0/0"]
  }

  ingress {
    description      = "HTTP"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::0/0"]
  }

  ingress {
    description      = "API"
    from_port        = 3000
    to_port          = 3000
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::0/0"]
  }

  ingress {
    description      = "Database from Amazon"
    from_port        = 3306
    to_port          = 3306
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  tags = {
    Name = "allow_ssh"
  }
}