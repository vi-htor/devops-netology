output "internal_ip_address_ts_server" {
  value = "${yandex_compute_instance.ts-server.network_interface.0.ip_address}"
}
output "external_ip_address_ts_server" {
  value = "${yandex_compute_instance.ts-server.network_interface.0.nat_ip_address}"
}

output "internal_ip_address_ts_agent" {
  value = "${yandex_compute_instance.ts-agent.network_interface.0.ip_address}"
}
output "external_ip_address_ts_agent" {
  value = "${yandex_compute_instance.ts-agent.network_interface.0.nat_ip_address}"
}

output "internal_ip_address_nexus" {
  value = "${yandex_compute_instance.nexus.network_interface.0.ip_address}"
}
output "external_ip_address_nexus" {
  value = "${yandex_compute_instance.nexus.network_interface.0.nat_ip_address}"
}
