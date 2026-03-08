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
        "modules-right" = ["pulseaudio" "temperature#cpu" "cpu" "custom/gpu_temp" "custom/gpu_usage" "disk#nvme" "disk#ssd"];
        "custom/clock" = {
          "format" = "󰃭  {}";
          "exec" = "LC_TIME=pt_BR.UTF-8 date '+%d de %B; %H=%M'";
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
          "exec" = "nvidia-smi --query-gpu=temperature.gpu --format=csv;noheader";
          "format" = "󰢮  {}°C";
          "interval" = 5;
        };
        "custom/gpu_usage" = {
          "exec" = "nvidia-smi --query-gpu=utilization.gpu --format=csv;noheader;nounits";
          "format" = "{}%";
          "interval" = 5;
        };
        "disk#nvme" = {
          "path" = "/home";
          "format" = "󰋊  {percentage_used}%";
        };
        "disk#ssd" = {
          "path" = "/mnt/storage";
          "format" = "{percentage_used}%";
        };
      }
    ];
    style = builtins.readFile ../../wayland/.config/waybar/style.css;
  };
}
