resource "openstack_networking_secgroup_v2" "secgroup1" {
  name        = "SecurityDevice"
  description = "For external access to the Multi-Purpose Security Device host"
}

resource "openstack_networking_secgroup_rule_v2" "ssh-v6" {
  direction         = "ingress"
  ethertype         = "IPv6"
  protocol          = "tcp"
  port_range_min    = 22
  port_range_max    = 22
  remote_ip_prefix  = "::/0"
  security_group_id = openstack_networking_secgroup_v2.secgroup1.id
}

resource "openstack_networking_secgroup_v2" "secgroup0" {
  name        = "AllAccess"
  description = "Highly permissive between hosts - bad for production"
}

resource "openstack_networking_secgroup_rule_v2" "secgroup_rule_0" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 1
  port_range_max    = 65535
  remote_group_id   = openstack_networking_secgroup_v2.secgroup0.id
  security_group_id = openstack_networking_secgroup_v2.secgroup0.id
}

resource "openstack_networking_secgroup_rule_v2" "secgroup_rule_1" {
  direction         = "ingress"
  ethertype         = "IPv6"
  protocol          = "tcp"
  port_range_min    = 1
  port_range_max    = 65535
  remote_group_id   = openstack_networking_secgroup_v2.secgroup0.id
  security_group_id = openstack_networking_secgroup_v2.secgroup0.id
}

resource "openstack_networking_secgroup_rule_v2" "secgroup_rule_2" {
  direction         = "ingress"
  ethertype         = "IPv6"
  protocol          = "icmp"
  remote_group_id   = openstack_networking_secgroup_v2.secgroup0.id
  security_group_id = openstack_networking_secgroup_v2.secgroup0.id
}

resource "openstack_networking_secgroup_rule_v2" "secgroup_rule_3" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "icmp"
  remote_group_id   = openstack_networking_secgroup_v2.secgroup0.id
  security_group_id = openstack_networking_secgroup_v2.secgroup0.id
}

resource "openstack_networking_secgroup_rule_v2" "secgroup_rule_4" {
  direction         = "ingress"
  ethertype         = "IPv6"
  protocol          = "tcp"
  port_range_min    = 22
  port_range_max    = 22
  remote_ip_prefix  = "::/0"
  security_group_id = openstack_networking_secgroup_v2.secgroup0.id
}
