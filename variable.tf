#variable "vpc_id" { default = "" }
variable "aws_access_key" { default = "xxxxxxxxxxxx" }
variable "aws_secret_key" { default = "xxxxxxxxxxxxxxxxxxxxxxxxx" }
#variable "aws_region" { default = "us-east-1" }
#variable "avail_zone" { default = "us-east-1a" }

variable "PATH_TO_PRIVATE_KEY" {
  default = "./ssh.pem"
}

variable "key" {
  default = "ssh.pem"
}
