linux: 
	@stow -t ~ --adopt -vv terminal i3-config
	@sudo stow -t / --adopt -vv devices

.PHONY: linux

macos:
	@stow -t ~ --adopt -vv shell-macos terminal



