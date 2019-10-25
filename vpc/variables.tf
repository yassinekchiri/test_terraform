######VARIABLES#########

variable "azs" {
  default = "eu-west-1a"
}

variable region {
  default = "eu-west-1"
}

variable application {
  default = "lab"
}

variable environment {
  default = "d2si"
}

variable owner {
  default = "me"
}

variable "cidr_block" {
  default = "172.23.0.0/16"
}

variable "subnet_cidr" {
  default = "172.23.1.0/24"
}
