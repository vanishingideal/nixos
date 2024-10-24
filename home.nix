{
  config,
  pkgs,
  libs,
  inputs,
  ...
}: {
  imports = [
    ./modules/prg/tmux.nix
    ./modules/prg/emacs.nix
    ./modules/prg/nixvim.nix
    ./modules/prg/git.nix
    ./modules/env/gtk.nix
  ];
  home = {
    stateVersion = "24.05";
    username = "vanishingideal";
    homeDirectory = "/home/vanishingideal";
    packages = with pkgs; [
      newsboat
      firefox
      google-chrome
      tmux
      xclip
      btop
      jujutsu
      feh
      alacritty
      zathura
      obsidian
      vlc
      irssi
      lmstudio
      dmenu
      gron
      devenv
      direnv
      ripgrep
      git-crypt
      yt-dlp
      jq
      gh
      alejandra
      man-pages
      linux-manual
      man-pages-posix
      ncmpcpp
    ];
  };
  services.xscreensaver = {
    enable = true;
    settings = {
      timeout = 10;
    };
  };

  fonts.fontconfig.enable = true;
}
