resource "yandex_compute_instance" "nexus" {
  name                      = "nexus"
  zone                      = "ru-central1-a"
  hostname                  = "nexus.netology.cloud"
  allow_stopping_for_update = true

  resources {
    cores  = 2
    memory = 4
  }

  boot_disk {
    initialize_params {
      image_id    = "${var.alma-9}"
      name        = "root-nexus"
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