variable "availability_zone_a" {
  type    = string
  default = "us-east-2a"
}
variable "availability_zone_b" {
  type    = string
  default = "us-east-2b"
}
variable "availability_zone_c" {
  type    = string
  default = "us-east-2c"
}

variable "cluster_name" {
  type    = string
  default = "cassandra_high"
}

variable "user_name" {
  type    = string
  default = "devops"
}