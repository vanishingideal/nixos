{
  config,
  pkgs,
  ...
}: {
  programs = {
    nushell = {
      enable = true;
      configFile.source = "/etc/nixos/modules/prg/nu/config.nu";
    };
  };
}
