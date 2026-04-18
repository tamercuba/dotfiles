{...}: {
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    settings = [
      {
        "layer" = "top";
        "position" = "top";
        "height" = 30;
        "modules-left" = ["hyprland/workspaces"];
        "modules-center" = ["custom/clock"];
        "modules-right" = ["pulseaudio" "temperature#cpu" "cpu" "custom/gpu_temp" "custom/gpu_usage" "custom/disk_nvme" "custom/disk_sata" "custom/corne_battery"];
        "custom/clock" = {
          "format" = "󰃭  {}";
          "exec" = "LC_TIME=pt_BR.UTF-8 date '+%d de %B, %H:%M'";
          "interval" = 1;
          "tooltip" = false;
        };
        "pulseaudio" = {
          "format" = "󰕾  {volume}%";
          "format-muted" = "󰖁  Mudo";
          "tooltip-format" = "{desc}";
          "on-click" = "~/.local/bin/toggle-audio-sink-clj";
        };
        "temperature#cpu" = {
          "hwmon-path" = "/sys/class/hwmon/hwmon2/temp1_input";
          "format" = "󰻠  {temperatureC}°C";
        };
        "cpu" = {
          "format" = "{usage}%";
          "interval" = 2;
        };
        "custom/gpu_temp" = {
          "exec" = "nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader";
          "format" = "󰢮  {}°C";
          "interval" = 5;
        };
        "custom/gpu_usage" = {
          "exec" = "nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits";
          "format" = "{}%";
          "interval" = 5;
        };
        "custom/disk_nvme" = {
          "exec" = "echo \"$(df /home | awk 'NR==2{print $5}') $(awk '{printf \"%d°C\", $1/1000}' /sys/class/hwmon/hwmon0/temp1_input)\"";
          "format" = "󰋊  {}";
          "interval" = 10;
          "tooltip" = false;
        };
        "custom/disk_sata" = {
          "exec" = "echo \"$(df /mnt/storage | awk 'NR==2{print $5}') $(sudo smartctl -A /dev/sda | awk '/Temperature_Celsius/{print $10\"°C\"}')\"";
          "format" = "  {}";
          "interval" = 30;
          "tooltip" = false;
        };
        "custom/corne_battery" = {
          "exec" = "$HOME/.local/bin/corne-battery";
          "return-type" = "json";
          "interval" = 15;
          "escape" = false;
        };
      }
    ];
    style = builtins.readFile ../../../wayland/.config/waybar/style.css;
  };
}
