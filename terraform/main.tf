resource "openstack_compute_instance_v2" "security" {
  name            = "security-device"
  image_name      = var.image
  flavor_name     = var.flavor
  key_pair        = var.keypair
  security_groups = [openstack_networking_secgroup_v2.secgroup0.name, openstack_networking_secgroup_v2.secgroup1.name]
  network {
    name          = "default"
  }
  network {
    name          = openstack_networking_network_v2.attack-net.name
  }
  network {
    name          = openstack_networking_network_v2.target-net.name
  }
}

resource "openstack_compute_instance_v2" "attack" {
  name            = "attack-host"
  image_name      = var.image
  flavor_name     = var.flavor
  key_pair        = var.keypair
  security_groups = [openstack_networking_secgroup_v2.secgroup0.name]
  network {
    name          = openstack_networking_network_v2.attack-net.name
    fixed_ip_v4   = "192.168.253.253"
  }
}

resource "openstack_compute_instance_v2" "target" {
  name            = "target-host"
  image_name      = var.image
  flavor_name     = var.flavor
  key_pair        = var.keypair
  security_groups = [openstack_networking_secgroup_v2.secgroup0.name]
  network {
    name          = openstack_networking_network_v2.target-net.name
    fixed_ip_v4   = "192.168.249.253"
  }
}

resource "null_resource" "provision" {
  depends_on = [openstack_compute_instance_v2.security,
                openstack_compute_instance_v2.attack,
                openstack_compute_instance_v2.target]
  provisioner "remote-exec" {
  inline = ["echo 'Hello World'"]

  connection {
    user        = "ubuntu"
    private_key = file(var.private_key_path)
    host        = chomp(openstack_compute_instance_v2.security.access_ip_v6)
  }
}

  provisioner "local-exec" {
    command = "ansible-playbook -i ../ansible/inventory ../ansible/main.yml"
  }
}
