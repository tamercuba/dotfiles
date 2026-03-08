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

  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/vda";
  boot.loader.grub.useOSProber = true;

  users.users.tamer = {
    isNormalUser = true;
    description = "tamer";
    extraGroups = ["networkmanager" "wheel" "video" "input"];
    shell = pkgs.zsh;
  };

  home-manager = {
    users.tamer = {
      imports = [
        ../../home/linux.nix
        ../../home/hosts/tamer-pc.nix
      ];
    };
    extraSpecialArgs = {
      inherit pkgs pkgs-unstable;
    };
  };

  system.stateVersion = "25.11";
}
