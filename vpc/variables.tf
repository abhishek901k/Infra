variable "public_subnet_cidr_a" {
  description = "CIDR block for the public subnet in AZ A."
  type        = string
  default     = "10.0.1.0/24"
}

variable "public_subnet_cidr_b" {
  description = "CIDR block for the public subnet in AZ B."
  type        = string
  default     = "10.0.2.0/24"
}

variable "private_subnet_cidr_a" {
  description = "CIDR block for the private subnet in AZ A."
  type        = string
  default     = "10.0.3.0/24"
}

variable "private_subnet_cidr_b" {
  description = "CIDR block for the private subnet in AZ B."
  type        = string
  default     = "10.0.4.0/24"
}

variable "aws_region" {
  description = "Region in which AWS Resource to be created"
  type        = string
  default     = "ap-south-1"
}

variable "vpc_cidr_block" {
  description = "CIDR block for the VPC."
  type        = string
  default     = "10.0.0.0/16"
}