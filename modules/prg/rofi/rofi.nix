{pkgs, ...}: {
  programs.rofi = {
    enable = true;
    theme = "/etc/nixos/modules/prg/rofi/config.rasi";
  };
}
