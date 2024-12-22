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
    virt-manager.enable = true;
    nh = {
      enable = true;
      flake = "/etc/nixos";
    };

    dconf.enable = true;
    appimage = {
      enable = true;
      binfmt = true;
    };
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };
  nix = {
    extraOptions = ''
      trusted-users = root vanishingideal
    '';
    settings = {
      experimental-features = ["nix-command" "flakes"];
      trusted-substituters = ["https://cache.flox.dev"];
      trusted-public-keys = ["flox-cache-public-1:7F4OyH7ZCnFhcze3fJdfyXYLQw/aV7GEed86nQ7IsOs="];
    };
  };

  time.timeZone = "Europe/Monaco";

  i18n.defaultLocale = "en_US.UTF-8";

  services = {
    displayManager = {
      sddm = {
        enable = true;
        theme = "catppuccin-mocha";
        package = pkgs.kdePackages.sddm;
      };
      defaultSession = "none+dwm";
    };
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

    tlp.settings = {
      WIFI_PWR_ON_AC = "off";
      WIFI_PWR_ON_BAT = "off";
      USB_AUTOSUSPEND = "0";
    };

    mpd = {
      enable = true;
      network.listenAddress = "0.0.0.0";
      user = "vanishingideal";
      musicDirectory = "/home/vanishingideal/a";
      extraConfig = ''
        log_level "default"
        auto_update "yes"
      '';

      startWhenNeeded = true;
    };
  };
  systemd.services.mpd.environment = {
    # https://gitlab.freedesktop.org/pipewire/pipewire/-/issues/609
    XDG_RUNTIME_DIR = "/run/user/1000";
  };

  hardware = {
    graphics = {
      enable = true;
    };
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
  security.polkit.enable = true;

  users.users.vanishingideal = {
    isNormalUser = true;
    shell = pkgs.nushell;
    description = "vanishingideal";
    extraGroups = ["libvirtd" "networkmanager" "wheel"];
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

      dive

      podman-tui
      podman-compose

      (catppuccin-sddm.override {
        flavor = "mocha";
        font = "Jetbrains Mono";
        fontSize = "9";
        loginBackground = true;
      })
    ];
    variables = {
      BROWSER = "firefox";
    };
  };

  nixpkgs.config.allowUnfree = true;
  virtualisation = {
    podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true;
    };
    docker.rootless = {
      enable = true;
      setSocketVariable = true;
    };
    libvirtd = {
      enable = true;
      package = pkgs.libvirt;
    };
  };

  fonts.packages = with pkgs; [
    cascadia-code
  ];
}
