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

