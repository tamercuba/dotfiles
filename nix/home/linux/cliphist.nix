{...}: {
  systemd.user.services.cliphist-text = {
    Unit.Description = "cliphist text watcher";
    Unit.PartOf = ["graphical-session.target"];
    Unit.After = ["graphical-session.target"];
    Install.WantedBy = ["graphical-session.target"];
    Service = {
      ExecStart = "wl-paste --type text --watch cliphist store";
      Restart = "on-failure";
    };
  };

  systemd.user.services.cliphist-image = {
    Unit.Description = "cliphist image watcher";
    Unit.PartOf = ["graphical-session.target"];
    Unit.After = ["graphical-session.target"];
    Install.WantedBy = ["graphical-session.target"];
    Service = {
      ExecStart = "wl-paste --type image --watch cliphist store";
      Restart = "on-failure";
    };
  };
}
