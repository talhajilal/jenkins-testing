
variable "type"                     {}
variable "from_port"                {}
variable "to_port"                  {}
variable "protocol"                 {}
variable "source_sg"                {}
variable "cidr_blocks"  {
  type = list(string)
}
variable "security_group_id"        {}