resource "yandex_compute_instance" "redis-03" {
  name                      = "redis-03"
  zone                      = "ru-central1-a"
  hostname                  = "redis-03.netology.cloud"
  allow_stopping_for_update = true

  resources {
    cores  = 2
    memory = 4
  }

  boot_disk {
    initialize_params {
      image_id    = "${var.alma-9}"
      name        = "root-redis-03"
      type        = "network-nvme"
      size        = "20"
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