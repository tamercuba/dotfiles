return {
	cmd = { "nixd" },
	filetypes = { "nix" },
	root_markers = { "flake.nix", ".git" },
	settings = {
		nixd = {
			nixpkgs = {
				expr = 'import (builtins.getFlake "/mnt/storage/projects/dotfiles").inputs.nixpkgs {}',
			},
			formatting = {
				command = { "alejandra" },
			},
			options = {
				nixos = {
					expr = '(builtins.getFlake "/mnt/storage/projects/dotfiles").nixosConfigurations.tamer-pc.options',
				},
			},
		},
	},
}
