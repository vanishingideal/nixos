{
  config,
  pkgs,
  inputs,
  dwm,
  lib,
  ...
}: {
  imports = [./hardware-configuration.nix];

  system.stateVersion = "24.05";

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    initrd = {
      systemd.network.wait-online.enable = false;
      luks.devices."luks-81843bbb-b573-4628-bebb-d6b55d4675af".device = "/dev/disk/by-uuid/81843bbb-b573-4628-bebb-d6b55d4675af";
    };
    kernelPackages = pkgs.linuxPackagesFor pkgs.linux_latest;
  };

  networking = {
    networkmanager.enable = true;
    nameservers = ["1.1.1.1" "1.0.0.1"];
    hostName = "prime";
    dhcpcd.wait = "background";
    firewall = {
      enable = true;
      trustedInterfaces = ["tailscale0"];
      allowedUDPPorts = [config.services.tailscale.port];
      rejectPackets = true;
      allowPing = false;
    };
  };

  documentation = {
    enable = true;
    nixos.includeAllModules = true;
    man = {
      enable = true;
      generateCaches = true;
    };
    dev.enable = true;
  };

  programs = {
    dconf.enable = true;
    appimage = {
      enable = true;
      binfmt = true;
    };
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    fish = {
      enable = true;
      interactiveShellInit = ''
               set -gx --path fish_function_path "/etc/nixos/modules/prg/fish" $fish_function_path
        source "/etc/nixos/modules/prg/fish/prompt.fish"
        theme_gruvbox dark
      '';
    };
  };

  nix = {
    extraOptions = ''
      trusted-users = root vanishingideal
    '';
    settings.experimental-features = ["nix-command" "flakes"];
  };

  time.timeZone = "Europe/Monaco";

  i18n.defaultLocale = "en_US.UTF-8";

  services = {
    displayManager.sddm.enable = true;
    displayManager.defaultSession = "none+dwm";
    xserver = {
      enable = true;
      windowManager.dwm = {
        enable = true;
        package = pkgs.dwm.overrideAttrs {
          src = dwm;
        };
      };
      xkb = {
        layout = "us";
        variant = "";
      };
    };
    tailscale.enable = true;
    emacs = {
      enable = true;
      package = pkgs.emacs;
    };
    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
    };
    libinput.enable = true;
    openssh.enable = true;
  };

  hardware = {
    pulseaudio.enable = false;
    bluetooth = {
      enable = true;
      powerOnBoot = true;
      package = pkgs.bluez;
      settings = {
        Policy = {
          AutoEnable = "true";
        };
        General = {
          FastConnectable = "true";
          AutoConnect = "true";
        };
      };
    };
  };

  security.rtkit.enable = true;

  users.users.vanishingideal = {
    isNormalUser = true;
    shell = pkgs.fish;
    description = "vanishingideal";
    extraGroups = ["networkmanager" "wheel"];
    packages = with pkgs; [];
  };

  environment = {
    systemPackages = with pkgs; [
      nh
      nil
      nix-tree
      nix-output-monitor
      bluez
      bluez-tools
      bluez-alsa
    ];
    shellAliases = {
      v = "nvim";
      rebuild = "cd /etc/nixos && sudo nixos-rebuild switch --flake .#default";
      gc = "sudo nix-collect-garbage -d";
      e = "emacsclient -t";
      cc = "gcc -Wall -Werror -Wextra -pedantic -std=gnu89 -g $1 -o $(echo $1 | cut -d . -f1)";
      yt = "yt-dlp --cookies-from-browser firefox -f ba -x";
      pbcopy = "xclip -selection clipboard";
      pbpaste = "xclip -selection clipboard -o";
    };
  };

  nixpkgs.config.allowUnfree = true;

  virtualisation.virtualbox.host.enable = true;

  users.extraGroups.vboxusers.members = ["user-with-access-to-virtualbox"];

  fonts.packages = with pkgs; [
    fira-code
    fira-code-symbols
    cascadia-code
  ];
}
