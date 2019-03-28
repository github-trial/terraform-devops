## variable declaration
#variable "aws_access_key" {}
#variable "aws_secret_key" {}


## Configure the AWS Provider
provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "eu-west-1"
}

## VPC
module "vpc" {
  source = "module/vpc/"
}

## SG
module "sg" {
  source = "module/sg/"
  vpc_id = "${module.vpc.vpc_id}"
}

# EC2
module "ec2" {
  source = "module/ec2/"
  subnet_id = "${module.vpc.sub-id}"
  vpc_id = "${module.vpc.vpc_id}"
  vpc_security_group_ids = ["${module.sg.sg-id}"]
}
