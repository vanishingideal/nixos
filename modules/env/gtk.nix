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
      name = "JetBrains Mono NL Bold 10";
    };

    iconTheme = {
      package = pkgs.gruvbox-dark-icons-gtk;
      name = "gruvbox-dark-icons-gtk";
    };
  };
}
