{
  config,
  pkgs,
  libs,
  inputs,
  ...
}: {
  imports = [
    ./modules/prg/tmux.nix
    ./modules/prg/direnv.nix
    ./modules/prg/emacs.nix
    ./modules/prg/nixvim.nix
    ./modules/prg/kitty.nix
    ./modules/prg/zathura.nix
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
      brave
      ranger
      nushell
      fzf
      unzip
      git-credential-manager
      bat
      tree
      tmux
      jetbrains-mono
      xclip
      btop
      direnv
      jujutsu
      feh
      obsidian
      vlc
      irssi
      lmstudio
      rofi
      gron
      ripgrep
      git-crypt
      yt-dlp
      jq
      gh
      alejandra
      man-pages
      linux-manual
      man-pages-posix
      kitty
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
