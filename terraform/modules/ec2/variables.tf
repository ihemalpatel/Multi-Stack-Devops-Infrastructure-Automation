variable "ami_id" {
    description = "AMI ID used for EC2 instance"
    type = string
    default = "ami-01f79b1e4a5c64257"
}

variable "instance_type" {
    description = "Instance type used for EC2 instance"
    type = string
    default = "t2.micro"
}

variable "name" {
    description = "Name of the EC2 instance"
    type = string
}