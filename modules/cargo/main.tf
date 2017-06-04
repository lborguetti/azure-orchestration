resource "azurerm_resource_group" "rg" {
  name     = "${var.env}-cargo-rg"
  location = "${var.location}"
}
