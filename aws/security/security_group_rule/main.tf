resource "aws_security_group_rule" "rule_with_cidr_blocks" {
  count                     = "${length(var.cidr_blocks)}"
  type                      = "${var.type}"
  from_port                 = "${var.from_port}"
  to_port                   = "${var.to_port}"
  protocol                  = "${var.protocol}"
  cidr_blocks               = "${var.cidr_blocks}"
  security_group_id         = "${var.security_group_id}"
}
resource "aws_security_group_rule" "rule_with_source_sg" {
  count                     = "${var.source_sg != "" ? 1 : 0}"
  type                      = "${var.type}"
  from_port                 = "${var.from_port}"
  to_port                   = "${var.to_port}"
  protocol                  = "${var.protocol}"
  source_security_group_id  = "${var.source_sg}"
  security_group_id         = "${var.security_group_id}"
}