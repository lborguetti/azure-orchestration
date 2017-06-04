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
