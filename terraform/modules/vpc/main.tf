
# VPC #
resource "aws_vpc" "FHS_VPC" {
cidr_block = "10.0.0.0/16"
instance_tenancy = "default"

tags = {
Name = "FHS-VPC"
}
}

#### Subnets ####
# Public Subbnet #

resource "aws_subnet" "public_subner" {
vpc_id = aws_vpc.FHS_VPC
cidr_block = "10.0.1.0/24"
map_public_ip_on_launch = true
availability_zone = "eu-central-1a"
}

# Private Subnet #

resource "aws_subnet" "private" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "eu-east-1"
  map_public_ip_on_launch = false
  

  tags = {
    Name = "private-subnet"
  }
}



##### Security Groups #####

resource "aws_security_group" "sg-FHS" {
name = "EC2SecurityGroup-FHS"
description = "Allow SSH access"
vpc_id = aws_vpc.FHS_VPC.id

ingress {
description = "SSH from anywhere"
from_port = 22
to_port = 22
protocol = "tcp"
cidr_blocks = ["0.0.0.0/0"]
}

ingress {
description = "HTTP from anywhere"
from_port = 80
to_port = 80
protocol = "tcp"
cidr_blocks = ["0.0.0.0/0"]
}

egress {
from_port = 0
to_port = 0
protocol = "-1"
cidr_blocks = ["0.0.0.0/0"]
}

tags = {
Name = "EC2SecurityGroup-FHS"
}
}


# Routing Table
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "private-route-table_FHS"
  }
}

#### PUBLIC ROUNTING TABLE

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
} 
resource "aws_route_table_association" "private_assoc" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.private.id
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "main-igw_FHS"
  }
}
resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public.id

  tags = {
    Name = "main-nat-gateway_FHS"
  }

  depends_on = [aws_internet_gateway.igw]
}


