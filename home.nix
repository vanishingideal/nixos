{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./modules/prg/tmux.nix
    ./modules/prg/emacs.nix
    ./modules/prg/git.nix
    ./modules/prg/picom.nix
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
      feh
      alacritty
      zathura
      obsidian
      vlc
      vim
      neovim
      irssi
      scrot
      lmstudio
      dmenu
      gron
      picom
      devenv
      direnv
      ripgrep
      git-crypt
      yt-dlp
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
