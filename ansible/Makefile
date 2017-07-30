.DEFAULT_GOAL := setup

env ?= dev
inventory ?= environments/$(env)
tags ?= all
user ?= core

.PHONY: bootstrap
bootstrap:
	ansible-playbook bootstrap.yml \
		-i $(inventory) \
		-l $(hosts) \
		-vvv

.PHONY: cargo
cargo:
	ansible-playbook cargo.yml \
		-i $(inventory) \
		-t $(tags) \
		-vvv

.PHONY: remote-shell
remote-shell:
	ansible $(hosts) \
		-i $(inventory) \
		-m shell \
		-b \
		-u $(user) \
		-e 'ansible_python_interpreter=/home/core/bin/python' \
		-a "$(shell)" \
		$(ansible-args)

.PHONY: setup
setup:
	pip install virtualenv
	virtualenv .venv-ansible
	source .venv-ansible/bin/activate && \
		pip install -r requirements.txt
