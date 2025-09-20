variable "vpc_cidr" {
    description = "The CIDR block for the VPC"
    type        = string
    default     = "10.0.0.0/16"  
}

variable "ap-vailability_zones" {
    description = "List of availability zones to use"
    type        = list(string)
    default     = ["ap-south-1a", "ap-south-1b", "ap-south-1c"] 
  
}

variable "public_subnet_cidrs" {
    description = "List of CIDR blocks for public subnets"
    type        = list(string)
    default     = ["10.0.10.0/24", "10.0.11.0/24" , "10.0.12.0/24" ]
}

variable "private_subnet_cidrs" {
    description = "List of CIDR blocks for private subnets"
    type        = list(string)
    default     = ["10.0.20.0/24", "10.0.21.0/24" , "10.0.22.0/24" ]
}


