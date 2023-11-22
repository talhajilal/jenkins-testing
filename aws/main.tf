provider "aws" {
    region = "us-east-1"
    access_key = "my-access-key"
    secret_key = "my-secret-key"
}
module "vpc" {
    source = "./vpc"
    vpc_name = "zaftech-kube1"
}

module "zaftech-esg" {
  source            = "./security/security_group"
  security_group_name = "zaftech-esg"
  security_group_vpc_id  = "${module.vpc.vpc_id}"
  security_group_description = "zaftech-ec2-security-group"
  security_group_tags = {
    Name   = "zaftech"
    env    = "Dev"
  }
}

module "zaftech-http_egress" {
 source = "./security/security_group_rule"
 type = "egress"
 from_port = "80"
 to_port = "80"
 protocol = "-1"
 source_sg = ""
 cidr_blocks = ["0.0.0.0/0"]
 security_group_id = "${module.zaftech-esg.security_group_id}"
}

module "bastion-host-sshkey" {
  source        = "./ssh-key"
  key_name = "bastion-host-sshkey"
}

module "bastion-host" {
source = "./bastion-host"
count_num = "1"
bastion_name = "JumpServer-01"
bastion_instance_type = "t2.micro"
script_file = "jenkins-install.sh"
#subnet_id = "${module.vpc.private_1_subnet_us_1},${module.vpc.public_1_subnet_us_1}"
subnet_id = "${module.vpc.public_1_subnet_us_1}"
ssh_key_name = "${module.bastion-host-sshkey.aws_key_name}"
vpc_id = "${module.vpc.vpc_id}"
}

# module "bastion-host_2" {
# source = "./bastion-host"
# bastion_name = "JumpServer-02"
# bastion_instance_type = "t2.micro"
# user_data = "jenkins-install.sh"
# #subnet_id = "${module.vpc.private_1_subnet_us_1},${module.vpc.public_1_subnet_us_1}"
# subnet_id = "${module.vpc.public_1_subnet_us_1}"
# ssh_key_name = "${module.bastion-host-sshkey.aws_key_name}"
# vpc_id = "${module.vpc.vpc_id}"
# }
