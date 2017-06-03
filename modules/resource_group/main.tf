resource "azurerm_resource_group" "rg" {
  name     = "${var.env}-${var.name_prefix}-rg"
  location = "${var.location}"
}
