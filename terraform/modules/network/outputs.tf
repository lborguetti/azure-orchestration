output "name" {
  value = "${azurerm_virtual_network.vnet.name}"
}

output "resource_group_name" {
  value = "${azurerm_resource_group.rg.name}"
}