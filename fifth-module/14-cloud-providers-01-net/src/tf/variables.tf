# Заменить на ID своего облака
variable "yandex_cloud_id" {
  default = ""
}

# Заменить на Folder своего облака
variable "yandex_folder_id" {
  default = ""
}

# ID образа
variable "os" {
  default = "fd8unsmfpl9uk01uodf2" #ubuntu 22.04
}

# ID образа для Nat
variable "nat-os" {
  default = "fd80mrhj8fl2oe87o4e1"
}

variable "nat-ip" {
  default = "192.168.10.254"
}