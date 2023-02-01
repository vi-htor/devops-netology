resource "local_file" "inventory" {
  content = <<-DOC
    # Ansible inventory containing variable values from Terraform.
    # Generated by Terraform.
    ---
    all:
      hosts:
        sonar-01:
          ansible_host: ${yandex_compute_instance.node01.network_interface.0.nat_ip_address}
        nexus-01:
          ansible_host: ${yandex_compute_instance.node02.network_interface.0.nat_ip_address}
      children:
        sonarqube:
          hosts:
            sonar-01:
        nexus:
          hosts:
            nexus-01:
        postgres:
          hosts:
            sonar-01:
      vars:
        ansible_connection_type: paramiko
        ansible_user: centos
        ansible_port: 22
        ansible_ssh_private_key_file: ../../../keys/id_rsa
    DOC
  filename = "../ansible/hosts.yml"

  depends_on = [
    yandex_compute_instance.node01,
    yandex_compute_instance.node02,
  ]
}
