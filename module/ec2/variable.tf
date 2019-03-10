#variable "ami-id" {
#  default = "ami-08935252a36e25f85"
#}
variable "AMIS" {
  type = "map"
  default = {
    us-east-1 = "ami-13be557e"
    us-west-2 = "ami-06b94666"
    eu-west-1 = "ami-08935252a36e25f85"
  }
}

variable "AWS_REGION" {
  default = "eu-west-1"
}

variable "no_of_instance" {
  default = "1"
}

variable "subnet_id" {
  default = "subnet-1234"
}

variable "instance-type" {
  default = "t2.medium"
}

variable "key" {
  default = "ssh"
}

variable "vpc_id" {
  default = ""
}

variable "vpc_security_group_ids" {
  default = ["sg-030b3d2"]
}

variable "PATH_TO_PRIVATE_KEY" {
  default = "./ssh.pem"
}

variable "PATH_TO_PUBLIC_KEY" {
  default = "./ssh.pem"
}

variable "INSTANCE_USERNAME" {
  default = "ec2-user"
}
#variable "userdata" { default = "" }
