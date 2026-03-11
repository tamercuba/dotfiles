{
  config,
  pkgs,
  pkgs-unstable,
  ...
}: {
  console.keyMap = "us-acentos";

  programs.hyprland = {
    enable = true;
    package = pkgs-unstable.hyprland;
    portalPackage = pkgs-unstable.xdg-desktop-portal-hyprland;
  };

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  environment.systemPackages = [
    pkgs.sddm-astronaut
    pkgs-unstable.uwsm
    pkgs.libnotify
    pkgs.gamemode
    pkgs.rose-pine-cursor
    pkgs.smartmontools
    pkgs.rclone
  ];

  programs.fuse.userAllowOther = true;

  systemd.tmpfiles.rules = [
    "d /mnt/drive 0755 tamer users -"
  ];

  security.sudo.extraRules = [{
    users = [ "tamer" ];
    commands = [{
      command = "/run/current-system/sw/bin/smartctl";
      options = [ "NOPASSWD" ];
    }];
  }];

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    extraCompatPackages = [ pkgs.proton-ge-bin ];
  };

  programs.gamemode.enable = true;

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    theme = "sddm-astronaut-theme";
    extraPackages = [pkgs.qt6.qtmultimedia];
    settings = {
      Theme = {
          CursorTheme = "BreezeX-RosePine-Linux";
          CursorSize = "35";
      };
    };
  };


  nixpkgs.config.allowUnfree = true;
  networking.networkmanager.enable = true;

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    extraConfig.pipewire."92-low-latency" = {
      context.properties = {
        default.clock.rate = 48000;
        default.clock.quantum = 512;
        default.clock.min-quantum = 512;
        default.clock.max-quantum = 512;
      };
    };
  };


  # ============================================================
  # NVIDIA — RTX 4060 (Ada Lovelace)
  # ============================================================

  services.xserver.videoDrivers = ["nvidia"];

  hardware.graphics.enable = true;
  hardware.graphics.enable32Bit = true;

  hardware.nvidia = {
    modesetting.enable = true;
    open = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };
}
