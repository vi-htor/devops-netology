resource "yandex_compute_instance" "private-vm" {
  name                      = "private-vm"
  zone                      = "ru-central1-a"
  hostname                  = "private-vm.netology.cloud"
  allow_stopping_for_update = true

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id    = "${var.os}"
      name        = "root-private-vm"
      type        = "network-nvme"
      size        = "20"
    }
  }

  network_interface {
    subnet_id = "${yandex_vpc_subnet.subnet-private.id}"
    nat       = false
  }

  metadata = {
    ssh-keys = "ubuntu:${file("../../../keys/id_rsa.pub")}"
  }
}