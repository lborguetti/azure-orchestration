module "network" {
  source = "../../../modules/network"

  env      = "${var.env}"
  location = "${var.location}"

  address_space = "${var.address_space}"
}
