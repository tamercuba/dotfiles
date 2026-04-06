{
  config,
  pkgs,
  pkgs-unstable,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ../../modules/common.nix
    ../../modules/linux.nix
  ];

  networking.hostName = "tamer-pc";

  boot.kernelPackages = pkgs.linuxPackages_zen;

  boot.loader.grub.enable = true;
  boot.loader.grub.device = "nodev";
  boot.loader.grub.efiSupport = true;
  boot.loader.efi.canTouchEfiVariables = true;

  users.users.tamer = {
    isNormalUser = true;
    description = "tamer";
    extraGroups = ["networkmanager" "wheel" "video" "input" "docker"];
    shell = pkgs.zsh;
  };

  virtualisation.docker.enable = true;

  home-manager = {
    users.tamer = {
      imports = [
        ../../home/linux.nix
        ../../home/hosts/tamer-pc.nix
      ];
    };
    extraSpecialArgs = {
      inherit pkgs pkgs-unstable;
      dotfilesDir = "/mnt/storage/projects/dotfiles";
    };
  };

  fileSystems."/mnt/storage" = {
    device = "/dev/disk/by-uuid/3e4c39a3-799a-42e6-92d5-fe7d136fac6a";
    fsType = "btrfs";
    options = ["defaults" "nofail"];
  };

  system.stateVersion = "25.11";
}
