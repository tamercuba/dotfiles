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
    ../../modules/keyboard.nix
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
      dotfilesDir = "/home/tamer/projects/dotfiles";
    };
  };

  fileSystems."/_btrfs" = {
    device = "/dev/disk/by-uuid/d73004f4-6c92-4246-85e9-a368b1cefdda";
    fsType = "btrfs";
    options = ["subvol=/" "defaults" "nofail"];
  };

  fileSystems."/home/tamer/games" = {
    device = "/dev/disk/by-uuid/d73004f4-6c92-4246-85e9-a368b1cefdda";
    fsType = "btrfs";
    options = ["subvol=@games" "defaults" "nofail"];
  };

  # UUID será atualizado na fase 4, após formatar o SATA
  fileSystems."/mnt/backup" = {
    device = "/dev/disk/by-uuid/eb4a70ca-5bd6-47ed-b236-81529253bf85";
    fsType = "btrfs";
    options = ["defaults" "nofail"];
  };

  services.btrbk = {
    instances.main = {
      onCalendar = "hourly";
      settings = {
        snapshot_preserve_min = "2d";
        snapshot_preserve = "7d";
        target_preserve_min = "no";
        target_preserve = "20d 10w *m";

        volume."/_btrfs".subvolume = {
          "@" = {};
          "@home" = {};
        };

        volume."/_btrfs".target = "/mnt/backup/@snapshots";
      };
    };
  };

  services.udisks2.enable = true;

  system.stateVersion = "25.11";
}
