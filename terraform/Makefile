.DEFAULT_GOAL := setup

env ?= dev

ENV_DIR = providers/azure/${env}
PLAN_FILE = terraform.tfplan
VAR_FILE = terraform.tfvars

.PHONY: setup
setup:
	@echo "Initiating terraform"
	@cd ${ENV_DIR}; \
		terraform init
	@echo "Done!"

.PHONY: terraform-plan
terraform-plan:
	cd ${ENV_DIR}; \
		terraform plan \
			-var-file=${VAR_FILE} \
			-out=${PLAN_FILE} \
			.

.PHONY: terraform-apply
terraform-apply:
	cd ${ENV_DIR}; \
		terraform apply ${PLAN_FILE}; \
			rm -f ${PLAN_FILE}

.PHONY: terraform-destroy
terraform-destroy:
	cd ${ENV_DIR}; \
		terraform destroy \
			-var-file=${VAR_FILE} \
			.
