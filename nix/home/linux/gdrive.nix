{pkgs, ...}: {
  systemd.user.services.rclone-gdrive = {
    Unit = {
      Description = "rclone Google Drive mount";
      After = [ "network-online.target" ];
      Wants = [ "network-online.target" ];
    };
    Service = {
      Type = "notify";
      ExecStart = "${pkgs.rclone}/bin/rclone mount google-drive: /mnt/drive --vfs-cache-mode writes --allow-other";
      ExecStop = "/run/wrappers/bin/fusermount -u /mnt/drive";
      Restart = "on-failure";
      RestartSec = "5s";
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
  };
}
