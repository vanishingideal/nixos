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
  home = {
    stateVersion = "24.05";
    username = "vanishingideal";
    homeDirectory = "/home/vanishingideal";
    packages = with pkgs; [
      newsboat
      firefox
      brave
      ranger
      borgbackup
      nushell
      openssl
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
      btop
      jujutsu
      feh
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
  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = ["qemu:///system"];
      uris = ["qemu:///system"];
    };
  };
}
