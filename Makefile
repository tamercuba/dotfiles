linux: 
	@stow -t ~ --adopt -vv shell tmux terminal i3-config
	@sudo stow -t / --adopt -vv devices

.PHONY: linux


macos:
	@stow -t ~ --adopt -vv shell-macos tmux terminal



