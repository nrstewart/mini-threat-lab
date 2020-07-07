resource "openstack_networking_network_v2" "attack-net" {
  name           = "attack"
  admin_state_up = "true"
}

data "openstack_dns_zone_v2" "zone" {
  name = "dev.syndicatestack.io."
}

resource "openstack_dns_recordset_v2" "security" {
  name    = "mpsd.dev.syndicatestack.io."
  type    = "AAAA"
  ttl     = "60"
  zone_id = data.openstack_dns_zone_v2.zone.id
  records = [openstack_compute_instance_v2.security.access_ip_v6]
}
resource "openstack_networking_subnet_v2" "attack-subnet" {
  name       = "attack"
  network_id = openstack_networking_network_v2.attack-net.id
  cidr       = "192.168.253.0/24"
  ip_version = 4
}

resource "openstack_networking_network_v2" "target-net" {
  name           = "target"
  admin_state_up = "true"
}

resource "openstack_networking_subnet_v2" "target-subnet" {
  name       = "target"
  network_id = openstack_networking_network_v2.target-net.id
  cidr       = "192.168.249.0/24"
  ip_version = 4
}
