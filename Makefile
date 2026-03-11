STOW_DIR := $(realpath $(dir $(abspath $(lastword $(MAKEFILE_LIST)))))
STOW     := stow --dir=$(STOW_DIR) --target=$(HOME)

linux:
	@$(STOW) terminal wayland

macos:
	@$(STOW) macos terminal

.PHONY: linux macos


# -----------------------------NIXOS------------------------------------------

rebuild-%:
	@sudo nixos-rebuild switch --flake ~/projects/dotfiles#$*
