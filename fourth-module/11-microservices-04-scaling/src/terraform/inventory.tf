resource "local_file" "inventory" {
  content = <<-DOC
    # Ansible inventory containing variable values from Terraform.
    # Generated by Terraform.
    ---
    all:
      hosts:
        redis-01:
          ansible_host: ${yandex_compute_instance.redis-01.network_interface.0.nat_ip_address}
        redis-02:
          ansible_host: ${yandex_compute_instance.redis-02.network_interface.0.nat_ip_address}
        redis-03:
          ansible_host: ${yandex_compute_instance.redis-03.network_interface.0.nat_ip_address}
      vars:
        ansible_connection_type: paramiko
        ansible_user: almalinux
        ansible_port: 22
        ansible_ssh_private_key_file: ../../../keys/id_rsa
    DOC
  filename = "../ansible/hosts.yml"

  depends_on = [
    yandex_compute_instance.redis-01,
    yandex_compute_instance.redis-02,
    yandex_compute_instance.redis-03
  ]
}
