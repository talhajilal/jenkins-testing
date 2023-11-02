output "aws_key_id" {
  value = "${aws_key_pair.ssh-key.id}"
}

output "aws_key_name" {
  value = "${aws_key_pair.ssh-key.key_name}"
}