resource "yandex_compute_instance" "public-vm" {
  name                      = "public-vm"
  zone                      = "ru-central1-a"
  hostname                  = "public-vm.netology.cloud"
  allow_stopping_for_update = true

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id    = "${var.os}"
      name        = "root-public-vm"
      type        = "network-nvme"
      size        = "20"
    }
  }

  network_interface {
    subnet_id = "${yandex_vpc_subnet.subnet-public.id}"
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file("../../../keys/id_rsa.pub")}"
  }
}