# Tasks

(Всё делал в Yandex.cloud)

1. Создал бакет, дал права сервисному пользователю:  
   ![screen1](src/img/screen1.png)  
   ![screen2](src/img/screen2.png)  
   Зарегистрировал бакет:  
   ```terraform
   terraform { 
     backend "s3" {
       endpoint   = "storage.yandexcloud.net"
       bucket     = "07-03-netology"
       region     = "ru-central1"
       key        = "s3/terraform.tfstate"
       access_key = "..."
       secret_key = "..."

       skip_region_validation      = true
       skip_credentials_validation = true
     }
   }
   ```
2. Output:
   ```bash
   $ terraform workspace list
     default
   * prod
     stage
   $ terraform plan

   Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
     + create

   Terraform will perform the following actions:

     # yandex_compute_instance.vm-1-count[0] will be created
     + resource "yandex_compute_instance" "vm-1-count" {
         + created_at                = (known after apply)
         + folder_id                 = (known after apply)
         + fqdn                      = (known after apply)
         + hostname                  = (known after apply)
         + id                        = (known after apply)
         + metadata                  = {
             + "ssh-keys" = <<-EOT
                   centos:ssh-rsa htor@Htors-Mac.local
               EOT
           }
         + name                      = "prod-count-0"
         + network_acceleration_type = "standard"
         + platform_id               = "standard-v1"
         + service_account_id        = (known after apply)
         + status                    = (known after apply)
         + zone                      = (known after apply)

         + boot_disk {
             + auto_delete = true
             + device_name = (known after apply)
             + disk_id     = (known after apply)
             + mode        = (known after apply)

             + initialize_params {
                 + block_size  = (known after apply)
                 + description = (known after apply)
                 + image_id    = "fd8jvcoeij6u9se84dt5"
                 + name        = (known after apply)
                 + size        = (known after apply)
                 + snapshot_id = (known after apply)
                 + type        = "network-hdd"
               }
           }

         + network_interface {
             + index              = (known after apply)
             + ip_address         = (known after apply)
             + ipv4               = true
             + ipv6               = (known after apply)
             + ipv6_address       = (known after apply)
             + mac_address        = (known after apply)
             + nat                = true
             + nat_ip_address     = (known after apply)
             + nat_ip_version     = (known after apply)
             + security_group_ids = (known after apply)
             + subnet_id          = (known after apply)
           }

         + placement_policy {
             + host_affinity_rules = (known after apply)
             + placement_group_id  = (known after apply)
           }

         + resources {
             + core_fraction = 100
             + cores         = 2
             + memory        = 2
           }

         + scheduling_policy {
             + preemptible = (known after apply)
           }
       }

     # yandex_compute_instance.vm-1-count[1] will be created
     + resource "yandex_compute_instance" "vm-1-count" {
         + created_at                = (known after apply)
         + folder_id                 = (known after apply)
         + fqdn                      = (known after apply)
         + hostname                  = (known after apply)
         + id                        = (known after apply)
         + metadata                  = {
             + "ssh-keys" = <<-EOT
                   centos:ssh-rsa htor@Htors-Mac.local
               EOT
           }
         + name                      = "prod-count-1"
         + network_acceleration_type = "standard"
         + platform_id               = "standard-v1"
         + service_account_id        = (known after apply)
         + status                    = (known after apply)
         + zone                      = (known after apply)

         + boot_disk {
             + auto_delete = true
             + device_name = (known after apply)
             + disk_id     = (known after apply)
             + mode        = (known after apply)

             + initialize_params {
                 + block_size  = (known after apply)
                 + description = (known after apply)
                 + image_id    = "fd8jvcoeij6u9se84dt5"
                 + name        = (known after apply)
                 + size        = (known after apply)
                 + snapshot_id = (known after apply)
                 + type        = "network-hdd"
               }
           }

         + network_interface {
             + index              = (known after apply)
             + ip_address         = (known after apply)
             + ipv4               = true
             + ipv6               = (known after apply)
             + ipv6_address       = (known after apply)
             + mac_address        = (known after apply)
             + nat                = true
             + nat_ip_address     = (known after apply)
             + nat_ip_version     = (known after apply)
             + security_group_ids = (known after apply)
             + subnet_id          = (known after apply)
           }

         + placement_policy {
             + host_affinity_rules = (known after apply)
             + placement_group_id  = (known after apply)
           }

         + resources {
             + core_fraction = 100
             + cores         = 2
             + memory        = 2
           }

         + scheduling_policy {
             + preemptible = (known after apply)
           }
       }

     # yandex_compute_instance.vm-1-fe["2"] will be created
     + resource "yandex_compute_instance" "vm-1-fe" {
         + created_at                = (known after apply)
         + folder_id                 = (known after apply)
         + fqdn                      = (known after apply)
         + hostname                  = (known after apply)
         + id                        = (known after apply)
         + metadata                  = {
             + "ssh-keys" = <<-EOT
                   centos:ssh-rsa htor@Htors-Mac.local
               EOT
           }
         + name                      = "prod-foreach-2"
         + network_acceleration_type = "standard"
         + platform_id               = "standard-v1"
         + service_account_id        = (known after apply)
         + status                    = (known after apply)
         + zone                      = (known after apply)

         + boot_disk {
             + auto_delete = true
             + device_name = (known after apply)
             + disk_id     = (known after apply)
             + mode        = (known after apply)

             + initialize_params {
                 + block_size  = (known after apply)
                 + description = (known after apply)
                 + image_id    = "fd8jvcoeij6u9se84dt5"
                 + name        = (known after apply)
                 + size        = (known after apply)
                 + snapshot_id = (known after apply)
                 + type        = "network-hdd"
               }
           }

         + network_interface {
             + index              = (known after apply)
             + ip_address         = (known after apply)
             + ipv4               = true
             + ipv6               = (known after apply)
             + ipv6_address       = (known after apply)
             + mac_address        = (known after apply)
             + nat                = true
             + nat_ip_address     = (known after apply)
             + nat_ip_version     = (known after apply)
             + security_group_ids = (known after apply)
             + subnet_id          = (known after apply)
           }

         + placement_policy {
             + host_affinity_rules = (known after apply)
             + placement_group_id  = (known after apply)
           }

         + resources {
             + core_fraction = 100
             + cores         = 2
             + memory        = 2
           }

         + scheduling_policy {
             + preemptible = (known after apply)
           }
       }

     # yandex_compute_instance.vm-1-fe["3"] will be created
     + resource "yandex_compute_instance" "vm-1-fe" {
         + created_at                = (known after apply)
         + folder_id                 = (known after apply)
         + fqdn                      = (known after apply)
         + hostname                  = (known after apply)
         + id                        = (known after apply)
         + metadata                  = {
             + "ssh-keys" = <<-EOT
                   centos:ssh-rsa  htor@Htors-Mac.local
               EOT
           }
         + name                      = "prod-foreach-3"
         + network_acceleration_type = "standard"
         + platform_id               = "standard-v1"
         + service_account_id        = (known after apply)
         + status                    = (known after apply)
         + zone                      = (known after apply)

         + boot_disk {
             + auto_delete = true
             + device_name = (known after apply)
             + disk_id     = (known after apply)
             + mode        = (known after apply)

             + initialize_params {
                 + block_size  = (known after apply)
                 + description = (known after apply)
                 + image_id    = "fd8jvcoeij6u9se84dt5"
                 + name        = (known after apply)
                 + size        = (known after apply)
                 + snapshot_id = (known after apply)
                 + type        = "network-hdd"
               }
           }

         + network_interface {
             + index              = (known after apply)
             + ip_address         = (known after apply)
             + ipv4               = true
             + ipv6               = (known after apply)
             + ipv6_address       = (known after apply)
             + mac_address        = (known after apply)
             + nat                = true
             + nat_ip_address     = (known after apply)
             + nat_ip_version     = (known after apply)
             + security_group_ids = (known after apply)
             + subnet_id          = (known after apply)
           }

         + placement_policy {
             + host_affinity_rules = (known after apply)
             + placement_group_id  = (known after apply)
           }

         + resources {
             + core_fraction = 100
             + cores         = 2
             + memory        = 2
           }

         + scheduling_policy {
             + preemptible = (known after apply)
           }
       }

     # yandex_vpc_network.network-1 will be created
     + resource "yandex_vpc_network" "network-1" {
         + created_at                = (known after apply)
         + default_security_group_id = (known after apply)
         + folder_id                 = (known after apply)
         + id                        = (known after apply)
         + labels                    = (known after apply)
         + name                      = "network1"
         + subnet_ids                = (known after apply)
       }

     # yandex_vpc_subnet.subnet-1 will be created
     + resource "yandex_vpc_subnet" "subnet-1" {
         + created_at     = (known after apply)
         + folder_id      = (known after apply)
         + id             = (known after apply)
         + labels         = (known after apply)
         + name           = "subnet1"
         + network_id     = (known after apply)
         + v4_cidr_blocks = [
             + "192.168.10.0/24",
           ]
         + v6_cidr_blocks = (known after apply)
         + zone           = "ru-central1-a"
       }

   Plan: 6 to add, 0 to change, 0 to destroy.

   Changes to Outputs:
     + external_ip_address_vm_1 = [
         + (known after apply),
         + (known after apply),
       ]
     + internal_ip_address_vm_1 = [
         + (known after apply),
         + (known after apply),
       ]

   ```