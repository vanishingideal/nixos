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
      jj
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
