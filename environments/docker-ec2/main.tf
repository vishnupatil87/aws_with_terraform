#################################################
# AMAZON LINUX 2023
#################################################

#################################################
# AMAZON LINUX 2023
#################################################

data "aws_ami" "amazon_linux" {

  most_recent = true

  owners = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023*-x86_64"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

#################################################
# EC2
#################################################

resource "aws_instance" "docker_server" {

  ami = data.aws_ami.amazon_linux.id

  instance_type = "t3.micro"

  subnet_id = aws_subnet.public.id

  key_name = "docker"

  vpc_security_group_ids = [

    aws_security_group.ec2_sg.id
  ]

user_data = <<-EOF
#!/bin/bash

set -eux

#################################################
# UPDATE SYSTEM
#################################################

dnf update -y

#################################################
# INSTALL PACKAGES
#################################################

dnf install -y \
docker \
git \
python3 \
python3-pip

#################################################
# ENABLE DOCKER
#################################################

systemctl enable docker
systemctl start docker

#################################################
# ADD USERS TO DOCKER GROUP
#################################################

usermod -aG docker ec2-user

#################################################
# VERIFY INSTALLATION
#################################################

docker --version
git --version
python3 --version
pip3 --version


# mkdir -p /home/ec2-user/app-stack

EOF

  tags = {

    Name = "docker-server"
  }
}