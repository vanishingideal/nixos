{
  pkgs,
  lib,
  ...
}: {
  gtk = {
    enable = true;
    theme = {
      name = "gruvbox-dark";
      package = pkgs.gruvbox-dark-gtk;
    };

    font = {
      name = "Noto Sans 10";
      package = pkgs.noto-fonts;
    };

    iconTheme = {
      package = pkgs.gruvbox-dark-icons-gtk;
      name = "gruvbox-dark-icons-gtk";
    };
  };
}
