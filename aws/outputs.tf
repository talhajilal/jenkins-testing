output "vpc_id" {
  value = "${module.vpc.vpc_id}"
}
output "private_1_subnet_us_1" {
  value = "${module.vpc.private_1_subnet_us_1}"
}
output "security_group_id" {
value = "${module.zaftech-esg.security_group_id}"
}

output "security_group_name" {
value = "${module.zaftech-esg.security_group_name}"
}

output "aws_key_name" {
value = "${module.bastion-host-sshkey.aws_key_name}"
}

output "bastion" {
  value = "${module.bastion-host.instance_public_ip}"  
}

output "name" {
  value = "${module.bastion-host.user_data_output}"
}