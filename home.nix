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
    ./modules/prg/rofi/rofi.nix
    ./modules/prg/nixvim.nix
    ./modules/prg/kitty.nix
    ./modules/prg/zathura.nix
    ./modules/prg/git.nix
    ./modules/env/gtk.nix
  ];
  nixpkgs.config = {
    allowUnfree = true;
  };
  home = {
    stateVersion = "24.05";
    username = "vanishingideal";
    homeDirectory = "/home/vanishingideal";
    packages = with pkgs; [
      newsboat
      brave
      borgbackup
      lmstudio
      btop
      nushell
      firefox
      ccze
      spotify
      openssl
      imhex
      vivid
      tealdeer
      vesktop
      fzf
      unzip
      git-credential-manager
      bat
      podman-desktop
      radicle-node
      tree
      tmux
      jetbrains-mono
      xclip
      jujutsu
      feh
      vlc
      irssi
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
      scrot
      imagemagick
      ncmpcpp
    ];
  };

  fonts.fontconfig.enable = true;
  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = ["qemu:///system"];
      uris = ["qemu:///system"];
    };
  };
}
