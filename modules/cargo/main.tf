resource "azurerm_resource_group" "rg" {
  name     = "${var.env}-cargo-rg"
  location = "${var.location}"
}

resource "azurerm_availability_set" "as" {
  name                         = "${var.env}-cargo-availability-set"
  location                     = "${var.location}"
  resource_group_name          = "${azurerm_resource_group.rg.name}"
  platform_fault_domain_count  = "${var.platform_fault_domain_count}"
  platform_update_domain_count = "${var.platform_update_domain_count}"
  managed                      = true
}

resource "azurerm_public_ip" "pubip" {
  name                         = "${var.env}-cargo-public-ip"
  location                     = "${var.location}"
  resource_group_name          = "${azurerm_resource_group.rg.name}"
  public_ip_address_allocation = "dynamic"
  domain_name_label            = "${var.env}-cargo"
}

resource "azurerm_lb" "lb" {
  name                = "${var.env}-cargo-load-balancer"
  location            = "${var.location}"
  resource_group_name = "${azurerm_resource_group.rg.name}"

  frontend_ip_configuration {
    name                 = "${var.env}-cargo-frontend-ip"
    public_ip_address_id = "${azurerm_public_ip.pubip.id}"
  }
}

resource "azurerm_lb_backend_address_pool" "lbbap" {
  name                = "${var.env}-cargo-backend-address-pool"
  resource_group_name = "${azurerm_resource_group.rg.name}"
  loadbalancer_id     = "${azurerm_lb.lb.id}"
}

resource "azurerm_lb_probe" "lbp" {
  name                = "${var.env}-cargo-load-balancer-probe"
  resource_group_name = "${azurerm_resource_group.rg.name}"
  loadbalancer_id     = "${azurerm_lb.lb.id}"
  protocol            = "tcp"
  port                = 80
  interval_in_seconds = 5
  number_of_probes    = 2
}

resource "azurerm_lb_rule" "lbr" {
  name                           = "${var.env}-cargo-load-balancer-rule"
  resource_group_name            = "${azurerm_resource_group.rg.name}"
  loadbalancer_id                = "${azurerm_lb.lb.id}"
  protocol                       = "tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = "${var.env}-cargo-frontend-ip"
  enable_floating_ip             = false
  backend_address_pool_id        = "${azurerm_lb_backend_address_pool.lbbap.id}"
  idle_timeout_in_minutes        = 5
  probe_id                       = "${azurerm_lb_probe.lbp.id}"
  depends_on                     = ["azurerm_lb_probe.lbp"]
}
