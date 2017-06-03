module "cargo-rg" {
  source = "../../modules/resource_group"

  env      = "${var.env}"
  location = "${var.location}"

  name_prefix = "cargo"
}
