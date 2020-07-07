resource "local_file" "ansible-inventory" {
 content = templatefile("inventory.tmpl",
 {
  security-dns     = openstack_dns_recordset_v2.security.name,
  attack-dns       = openstack_dns_recordset_v2.attack.name,
  target-dns       = openstack_dns_recordset_v2.target.name,
  security-ipv6    = trim(openstack_compute_instance_v2.security.access_ip_v6, "[]"),
  attack-ipv6      = trim(openstack_compute_instance_v2.attack.access_ip_v6, "[]"),
  target-ipv6      = trim(openstack_compute_instance_v2.target.access_ip_v6, "[]"),
  ansible-user     = "ubuntu",
  private-key-path = "~/.ssh/id_rsa"
 }
 )
 filename = "../ansible/inventory"
}
