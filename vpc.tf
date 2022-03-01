# Creating a VPC
resource "aws_vpc" "aditi_vpc" {
 cidr_block = "192.168.0.0/16"
 instance_tenancy= "default"
 enable_dns_hostnames=true
}

# Creating subnet
resource "aws_subnet" "public" {
 vpc_id= aws_vpc.aditi_vpc.id
 cidr_block= "192.168.1.0/24"
 availability_zone="ap-south-1a"

}

resource "aws_subnet" "private" {
 vpc_id=aws_vpc.aditi_vpc.id
 cidr_block="192.168.0.0/24"
 availability_zone="ap-south-1b"
}

# Creating security group

resource "aws_security_group" "prod-web-servers-sg" {
 name= "prod-web-servers-sg"
 description="Allow http,https,ssh,icmp"
 vpc_id= aws_vpc.aditi_vpc.id

 ingress { 
  description ="HTTP"
  from_port = 80
  to_port = 80
  protocol= "tcp"
  cidr_blocks= ["0.0.0.0/0"]
}
 ingress {
  description ="HTTPS"
  from_port = 443
  to_port = 443
  protocol= "tcp"
  cidr_blocks= ["0.0.0.0/0"]
}

 ingress {
  description ="SSH"
  from_port= 22
  to_port= 22
  protocol= "tcp"
  cidr_blocks= ["0.0.0.0/0"]
}
 ingress {
  description ="ALL ICMP-IPv4"
  from_port=-1
  to_port=-1
  protocol= "ICMP"
  cidr_blocks= ["0.0.0.0/0"]

}

 egress {
 from_port=0
 to_port=0
 protocol="-1"
 }
}

# Creating EC2 instance

resource "aws_instance" "prod-web-server-1" {
 ami = "ami-0e763a959ec839f5e"
 instance_type="t2.micro"
 
 tags= {
  Name= "prod-web-server-1"
 }
}

resource "aws_instance" "prod-web-server-2" {
 ami = "ami-0e763a959ec839f5e"
 instance_type="t2.micro"
 
 tags= {
  Name= "prod-web-server-2"
 }
}
