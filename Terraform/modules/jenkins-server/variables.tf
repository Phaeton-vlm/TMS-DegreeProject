variable "env" {
  type = string
  default = "dev"
}

variable "ingressports" {
  type    = list(number)
  default = [8080, 22]
}
