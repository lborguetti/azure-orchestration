env ?= dev

ENV_DIR = environments/${env}
VAR_FILE = ${ENV_DIR}/terraform.tfvars
STATE_FILE = ${ENV_DIR}/terraform.tfstate

.PHONY: terraform-get
terraform-get:
	terraform get ${ENV_DIR}

.PHONY: terraform-plan
terraform-plan: terraform-get
	terraform plan \
		-var 'env=${env}' \
		-var-file=${VAR_FILE} \
		-state=${STATE_FILE} \
		${ENV_DIR}

.PHONY: terraform-apply
terraform-apply:
	terraform apply \
		-var 'env=${env}' \
		-var-file=${VAR_FILE} \
		-state=${STATE_FILE} \
		${ENV_DIR}
