env ?= dev

ENV_DIR = environments/${env}
VAR_FILE = ${ENV_DIR}/terraform.tfvars
STATE_FILE = ${ENV_DIR}/terraform.tfstate

.PHONY: setup
setup:
	@echo "Copying git hooks"
	@cp githooks/pre-commit .git/hooks/pre-commit
	@chmod +x .git/hooks/pre-commit
	@echo "Done!"

.PHONY: terraform-get
terraform-get:
	terraform get ${ENV_DIR}

.PHONY: terraform-plan
terraform-plan: terraform-get
	terraform plan \
		-var-file=${VAR_FILE} \
		-state=${STATE_FILE} \
		${ENV_DIR}

.PHONY: terraform-apply
terraform-apply:
	terraform apply \
		-var-file=${VAR_FILE} \
		-state=${STATE_FILE} \
		${ENV_DIR}

.PHONY: terraform-destroy
terraform-destroy:
	terraform destroy \
		-var-file=${VAR_FILE} \
		-state=${STATE_FILE} \
		${ENV_DIR}
