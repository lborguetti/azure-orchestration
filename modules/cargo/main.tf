resource "azurerm_resource_group" "rg" {
  name     = "${var.env}-cargo-rg"
  location = "${var.location}"
}

resource "azurerm_subnet" "subnet" {
  name                 = "${var.env}-cargo-subnet"
  virtual_network_name = "${var.virtual_network_name}"
  resource_group_name  = "${var.virtual_network_resource_group_name}"
  address_prefix       = "${var.subnet_address_prefix}"
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

resource "azurerm_availability_set" "as" {
  name                         = "${var.env}-cargo-availability-set"
  location                     = "${var.location}"
  resource_group_name          = "${azurerm_resource_group.rg.name}"
  platform_fault_domain_count  = "${var.platform_fault_domain_count}"
  platform_update_domain_count = "${var.platform_update_domain_count}"
  managed                      = true
}

resource "azurerm_public_ip" "vmpubip" {
  name                         = "${var.env}-cargo-virutal-machine-public-ip-${count.index}"
  location                     = "${var.location}"
  resource_group_name          = "${azurerm_resource_group.rg.name}"
  public_ip_address_allocation = "dynamic"
  count                        = "${var.virtual_machine_count}"
}

resource "azurerm_network_interface" "ni" {
  name                = "${var.env}-cargo-network-interface-${count.index}"
  location            = "${var.location}"
  resource_group_name = "${azurerm_resource_group.rg.name}"
  count               = "${var.virtual_machine_count}"

  ip_configuration {
    name                                    = "${var.env}-cargo-ip-configuration-${count.index}"
    subnet_id                               = "${azurerm_subnet.subnet.id}"
    private_ip_address_allocation           = "dynamic"
    public_ip_address_id                    = "${element(azurerm_public_ip.vmpubip.*.id, count.index)}"
    load_balancer_backend_address_pools_ids = ["${azurerm_lb_backend_address_pool.lbbap.id}"]
  }
}

resource "azurerm_virtual_machine" "vm" {
  name                  = "${var.env}-cargo-virtual-machine-${count.index}"
  location              = "${var.location}"
  resource_group_name   = "${azurerm_resource_group.rg.name}"
  availability_set_id   = "${azurerm_availability_set.as.id}"
  vm_size               = "${var.virtual_machine_size}"
  network_interface_ids = ["${element(azurerm_network_interface.ni.*.id, count.index)}"]
  count                 = "${var.virtual_machine_count}"

  storage_image_reference {
    publisher = "CoreOS"
    offer     = "CoreOS"
    sku       = "Stable"
    version   = "1353.7.0"
  }

  storage_os_disk {
    name          = "${var.env}-cargo-os-disk-${count.index}"
    create_option = "FromImage"
  }

  os_profile {
    computer_name  = "${var.env}-cargo-virtual-machine-${count.index}"
    admin_username = "${var.virtual_machine_admin_username}"
    admin_password = "${var.virtual_machine_admin_password}"
    custom_data    = "${file("${path.module}/templates/cloud-config.yaml")}"
  }

  os_profile_linux_config {
    disable_password_authentication = true

    ssh_keys {
      path     = "/home/${var.virtual_machine_admin_username}/.ssh/authorized_keys"
      key_data = "${file("~/.ssh/id_rsa.pub")}"
    }
  }
}
