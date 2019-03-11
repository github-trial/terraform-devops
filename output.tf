## values form module vpc
output "vpc_id-mod" {
  value = "${module.vpc.vpc_id}"
}

output "gw_id-mod" {
  value       = "${module.vpc.gw_id}"
}

output "rt_id-mod" {
  value      = "${module.vpc.rt_id}"
}

output "sub-id-mod" {
  value      = "${module.vpc.sub-id}"
}

## values from module sg
output "sg-id-mod" {
  value       = "${module.sg.sg-id}"
}

## values form module ec2
output "instance-id-mod" {
value = "${module.ec2.instance-id}"
}

output "eip" {
value = "${module.ec2.eip}"
}

output "vol-id" {
value = "${module.ec2.vol-id}"
}
