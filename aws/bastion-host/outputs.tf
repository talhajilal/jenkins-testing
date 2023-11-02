output "instance_public_ip" {
 # value = aws_instance.bastion.public_ip
  value = [for instance in aws_instance.bastion : instance.public_ip]
  description = "The public IP address of the bastion instance."
}

output "instance_private_ip" {
#  value = aws_instance.bastion.private_ip[0]
  value = [for instance in aws_instance.bastion : instance.private_ip]
  description = "The private IP address of the bastion instance."
}

output "user_data_output" {
  value = [for instance in aws_instance.bastion : instance.user_data]
}  