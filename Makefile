STOW_DIR := $(realpath $(dir $(abspath $(lastword $(MAKEFILE_LIST)))))
STOW     := stow --dir=$(STOW_DIR) --target=$(HOME)

linux:
	@$(STOW) terminal wayland

macos:
	@$(STOW) shell-macos terminal

.PHONY: linux macos

