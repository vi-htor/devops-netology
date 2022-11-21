provider "yandex" {
  cloud_id  = "$YC_CLOUD_ID"
  folder_id = "$YC_FOLDER_ID"
  zone      = "ru-central1-a"
}
resource "yandex_compute_instance" "vm-1" {
  name = "test_vm1"
  resources {
    cores  = 1
    memory = 1
  }
  boot_disk {
    initialize_params {
      image_id = "fd89dg08jjghmn88ut7p"
	  name        = "test-vm1"
      type        = "network-nvme"
      size        = "40"
    }
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-1.id
    nat       = true
  }
  
}
resource "yandex_vpc_network" "network-1" {
  name = "network1"
}
resource "yandex_vpc_subnet" "subnet-1" {
  name           = "subnet1"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.network-1.id
  v4_cidr_blocks = ["192.168.10.0/24"]
}
output "internal_ip_address_vm_1" {
  value = yandex_compute_instance.vm-1.network_interface.0.ip_address
}
output "external_ip_address_vm_1" {
  value = yandex_compute_instance.vm-1.network_interface.0.nat_ip_address
}