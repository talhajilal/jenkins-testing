output "sg_rule_cidr_id" {
  value = "${aws_security_group_rule.rule_with_cidr_blocks.*.id }"
}

output "sg_rule_source_sg_id" {
  value = "${aws_security_group_rule.rule_with_source_sg.*.id}"
}