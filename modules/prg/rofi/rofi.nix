{pkgs, ...}: {
  programs.rofi = {
    enable = true;
    theme = ./config.rasi;

    extraConfig = {
      drun-display-format = "{name}";
    };
  };
}
