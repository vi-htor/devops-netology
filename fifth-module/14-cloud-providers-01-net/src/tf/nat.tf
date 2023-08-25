resource "yandex_compute_instance" "nat" {
  name                      = "nat"
  zone                      = "ru-central1-a"
  hostname                  = "nat.netology.cloud"
  allow_stopping_for_update = true

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id    = "${var.nat-os}"
      name        = "root-nat"
      type        = "network-nvme"
      size        = "20"
    }
  }

  network_interface {
    subnet_id = "${yandex_vpc_subnet.subnet-public.id}"
    ip_address = "${var.nat-ip}"
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file("../../../keys/id_rsa.pub")}"
  }
}