{
  config,
  pkgs,
  ...
}: {
  networking.extraHosts = ''
    127.0.0.1 docs.local
  '';

  services.nginx = {
    enable = true;
    virtualHosts."docs.local" = {
      listen = [
        {
          addr = "127.0.0.1";
          port = 80;
        }
      ];
      locations."/" = {
        proxyPass = "http://127.0.0.1:6666";
        proxyWebsockets = true;
      };
    };
  };
}
