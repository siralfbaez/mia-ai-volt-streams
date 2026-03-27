variable "vpc_id" {
  type = string
}

variable "region" {
  type    = string
  default = "us-east-1"
}

variable "ot_gateway_cidr" {
  description = "The CIDR block of the OT DMZ where the gateway resides"
  type        = string
}

variable "private_subnet_ids" {
  type = list(string)
}

variable "private_route_table_ids" {
  type = list(string)
}
