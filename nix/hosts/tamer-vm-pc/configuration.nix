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

  networking.hostName = "tamer-vm-pc";

  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/vda";
  boot.loader.grub.useOSProber = true;

  users.users.tamer-vm = {
    isNormalUser = true;
    description = "tamer";
    extraGroups = ["networkmanager" "wheel" "video" "input"];
  };

  home-manager = {
    users.tamer-vm = {
      imports = [
        ../../home/linux.nix
        ../../home/hosts/tamer-vm-pc.nix
      ];
    };
    extraSpecialArgs = {
      inherit pkgs pkgs-unstable;
    };
  };

  # VM only
  services.openssh.enable = true;

  system.stateVersion = "25.11";
}
