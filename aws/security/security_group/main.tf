resource "aws_security_group" "security_group" {
  name        = "${var.security_group_name}"
  description = "${var.security_group_description}"
  vpc_id      = "${var.security_group_vpc_id}"
 # tags        = "${var.security_group_tags}"
}