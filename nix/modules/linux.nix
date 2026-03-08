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
  ];

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
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
    pulse.enable = true;
  };


  # ============================================================
  # NVIDIA — GTX 4060 (Ada Lovelace)
  # Tunar após migração — hardware-configuration.nix do host real
  # pode mudar o que for necessário aqui
  # ============================================================

  # hardware.graphics.enable = true;
  # hardware.graphics.enable32Bit = true;

  # hardware.nvidia = {
  #   modesetting.enable = true;
  #   open = true;
  #   nvidiaSettings = true;
  #   package = config.boot.kernelPackages.nvidiaPackages.stable;
  # };
}
