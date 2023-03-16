variable "cidr_block" {
  type    = string
  default = "192.168.0.0/16"
}

variable "env" {
  type = string
  default = "dev"
}

variable "keyname" {
  type = string
  default = "vlm-key"
}