output "internal_ip_address_redis-01" {
  value = "${yandex_compute_instance.redis-01.network_interface.0.ip_address}"
}
output "external_ip_address_redis-01" {
  value = "${yandex_compute_instance.redis-01.network_interface.0.nat_ip_address}"
}

output "internal_ip_address_redis-02" {
  value = "${yandex_compute_instance.redis-02.network_interface.0.ip_address}"
}
output "external_ip_address_redis-02" {
  value = "${yandex_compute_instance.redis-02.network_interface.0.nat_ip_address}"
}

output "internal_ip_address_redis-03" {
  value = "${yandex_compute_instance.redis-03.network_interface.0.ip_address}"
}
output "external_ip_address_redis-03" {
  value = "${yandex_compute_instance.redis-03.network_interface.0.nat_ip_address}"
}
