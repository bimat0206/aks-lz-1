
resource "azurerm_network_interface" "example" {
  count               = length(var.vms)
  name                = "${var.prefix}-${var.vms[count.index].name}-nic"
  enable_accelerated_networking = true 
  enable_ip_forwarding = true 
  location            = data.azurerm_resource_group.example.location
  resource_group_name = var.resource_group_name
tags     = var.resource_labels
  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.example.id
    private_ip_address_allocation = "Dynamic"
    #public_ip_address_id = data.azurerm_public_ip.example.id
  }
}

resource "azurerm_windows_virtual_machine" "example" {
  count                 = length(var.vms)
  name                  = var.vms[count.index].name 
  location              = data.azurerm_resource_group.example.location
  resource_group_name   = var.resource_group_name
  network_interface_ids = [element(azurerm_network_interface.example[*].id, count.index)]
tags     = var.resource_labels
  size              = var.vms[count.index].vm_size
  admin_username      = var.vms[count.index].admin_username
  admin_password      = var.vms[count.index].admin_password
  os_disk {
    name              = "${var.vms[count.index].name}-osdisk"
    caching           = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  source_image_reference {
    publisher = var.vms[count.index].publisher
    offer     = var.vms[count.index].offer
    sku       = var.vms[count.index].sku
    version   = var.vms[count.index].version
  }


}

data "azurerm_subnet" "example" {
  name                 = var.subnet_name
  virtual_network_name = var.virtual_network_name
  resource_group_name  = var.resource_group_name
}
data "azurerm_resource_group" "example" {
  name = var.resource_group_name
}
/*
data "azurerm_public_ip" "example" {
  name                = var.public_ip_name
  resource_group_name = var.resource_group_name
}
*/