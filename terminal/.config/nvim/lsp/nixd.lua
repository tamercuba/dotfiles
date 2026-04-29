return {
	cmd = { "nixd" },
	filetypes = { "nix" },
	root_markers = { "flake.nix", ".git" },
	settings = {
		nixd = {
			nixpkgs = {
				expr = 'import (builtins.getFlake "/home/tamer/projects/dotfiles").inputs.nixpkgs {}',
			},
			formatting = {
				command = { "alejandra" },
			},
			options = {
				nixos = {
					expr = '(builtins.getFlake "/home/tamer/projects/dotfiles").nixosConfigurations.tamer-pc.options',
				},
			},
		},
	},
}
