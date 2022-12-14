resource "yandex_compute_instance" "clickhouse" {
  name                      = "clickhouse"
  zone                      = "ru-central1-a"
  hostname                  = "clickhouse.netology.cloud"
  allow_stopping_for_update = true

  resources {
    cores  = 2
    memory = 4
  }

  boot_disk {
    initialize_params {
      image_id    = "${var.alma-9}"
      name        = "root-clickhouse"
      type        = "network-nvme"
      size        = "50"
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