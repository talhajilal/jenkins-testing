resource "aws_key_pair" "ssh-key" {
  key_name   = "${var.key_name}"
  public_key = "${var.key_value}"
}
