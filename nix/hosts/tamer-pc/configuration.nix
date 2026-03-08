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
  };

  home-manager.users.tamer = import ../../home/linux.nix;

  system.stateVersion = "25.11";
}
