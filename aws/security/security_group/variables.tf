variable "security_group_name"        {}
variable "security_group_description" {}
variable "security_group_vpc_id"      {}
# variable "security_group_tags" {
#   type = "map"
# }
variable "security_group_tags" {
  type = map(string)
}