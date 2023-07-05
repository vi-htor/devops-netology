resource "yandex_compute_instance" "master-02" {
  name                      = "master-02"
  zone                      = "ru-central1-a"
  hostname                  = "master-02.netology.cloud"
  allow_stopping_for_update = true

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id    = "${var.os}"
      name        = "root-master-02"
      type        = "network-nvme"
      size        = "20"
    }
  }

  network_interface {
    subnet_id = "${yandex_vpc_subnet.default.id}"
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file("../../../keys/id_rsa.pub")}"
  }
}