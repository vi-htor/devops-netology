resource "yandex_compute_instance" "ts-server" {
  name                      = "ts-server"
  zone                      = "ru-central1-a"
  hostname                  = "ts-server.netology.cloud"
  allow_stopping_for_update = true

  resources {
    cores  = 4
    memory = 4
  }

  boot_disk {
    initialize_params {
      image_id    = "${var.alma-9}"
      name        = "root-ts-server"
      type        = "network-nvme"
      size        = "25"
    }
  }

  network_interface {
    subnet_id = "${yandex_vpc_subnet.default.id}"
    nat       = true
  }

  metadata = {
    ssh-keys = "almalinux:${file("../../../keys/id_rsa.pub")}"
  }
}