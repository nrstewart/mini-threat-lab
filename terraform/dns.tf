data "openstack_dns_zone_v2" "zone" {
  name = var.domain
}

resource "openstack_dns_recordset_v2" "security" {
  name    = "mpsd.${var.domain}"
  type    = "AAAA"
  ttl     = "60"
  zone_id = data.openstack_dns_zone_v2.zone.id
  records = [openstack_compute_instance_v2.security.access_ip_v6]
}

resource "openstack_dns_recordset_v2" "attack" {
  name    = "beligerent.${var.domain}"
  type    = "AAAA"
  ttl     = "60"
  zone_id = data.openstack_dns_zone_v2.zone.id
  records = [openstack_compute_instance_v2.attack.access_ip_v6]
}

resource "openstack_dns_recordset_v2" "target" {
  name    = "innocent.${var.domain}"
  type    = "AAAA"
  ttl     = "60"
  zone_id = data.openstack_dns_zone_v2.zone.id
  records = [openstack_compute_instance_v2.target.access_ip_v6]
}
