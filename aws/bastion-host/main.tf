data "aws_ami" "amazon-linux" {
  owners      = ["amazon"]
  most_recent = true

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }

  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-5.10-hvm*"]
  }
}

resource "aws_instance" "bastion" {
  count = var.count_num
  ami           = data.aws_ami.amazon-linux.id
  instance_type = var.bastion_instance_type
  key_name      = var.ssh_key_name
  subnet_id     = var.subnet_id
  #user_data = templatefile("./jenkins-install.sh", {file_content = "Jenkins node - ${count.index}"})
  user_data = templatefile("${path.root}/${var.script_file}", {file_content = "Jenkins node - ${count.index}"})

  tags = {
    Name = var.bastion_name
  }
  lifecycle {
    prevent_destroy = true
            }
  security_groups = ["${aws_security_group.allow_ssh_icmp.id}"]
}

resource "aws_security_group" "allow_ssh_icmp" {
  name        = "allow_ssh_icmp"
  description = "Allow SSH and ALL ICMP IPV4 inbound traffic"
  vpc_id      = var.vpc_id

  ingress {
    description = "SSH from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.cidr_block]
  }

  ingress {
    description = "ALL ICMP IPV4 from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "icmp"
    cidr_blocks = [var.cidr_block]
  }
  ingress {
    description = "http  for jenkins from VPC"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = [var.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_ssh"
  }
}