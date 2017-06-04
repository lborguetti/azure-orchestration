module "cargo" {
  source = "../../modules/cargo"

  env = "${var.env}"
  location = "${var.location}"
}
