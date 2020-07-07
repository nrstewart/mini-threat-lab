provider "openstack" {
  user_name   = var.user-project-tenant
  tenant_name = var.user-project-tenant
  password    = var.password
  auth_url    = "https://keystone-${var.region}.cloud.cybera.ca:5000/v3"
}


