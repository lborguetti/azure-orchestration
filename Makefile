.PHONY: setup
setup:
	@echo "Copying git hooks"
	@cp githooks/pre-commit .git/hooks/pre-commit
	@chmod +x .git/hooks/pre-commit
	@echo "Updating submodules"
	@git submodule update --init --recursive
	@echo "Done!"
