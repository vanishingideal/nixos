{
  config,
  dwm,
  pkgs,
  inputs,
  lib,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  system = {
    stateVersion = "24.11";
    autoUpgrade = {
      enable = true;
      dates = "weekly";
    };
  };

  # Bootloader.

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelModules = ["thinkpad_acpi"];
  boot.kernelParams = ["thinkpad_acpi.fan_control=1" "thinkpad_acpi.experimental=1" "acpi_osi=Linux"];

  boot.initrd.luks.devices."luks-542aa02d-d5ff-45c9-a70c-4aee718c6773".device = "/dev/disk/by-uuid/542aa02d-d5ff-45c9-a70c-4aee718c6773"; # /home
  boot.initrd.luks.devices."luks-54070300-bb2a-4c7f-acef-a06947ba8f6d".device = "/dev/disk/by-uuid/54070300-bb2a-4c7f-acef-a06947ba8f6d"; # /
  
  fileSystems."/home" = {
    device = "/dev/disk/by-uuid/370d1d70-62e3-4b8c-af9d-e3c9d1c7f84a";
    fsType = "ext4";
  };

  zramSwap.enable = true;
  networking = {
    networkmanager = {
      enable = true;
      wifi.backend = "wpa_supplicant";
    };

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
    yazi = {
      enable = true;
    };
    virt-manager.enable = true;
    steam.enable = true;
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
      auto-optimise-store = true;
      experimental-features = ["nix-command" "flakes"];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "cuda-maintainers.cachix.org-1:0dq3bujKpuEPMCX6U4WylrUDZ9JyUG0VpVZa7CNfq5E="
      ];
      substituters = [
        "https://nix-community.cachix.org"
        "https://cuda-maintainers.cachix.org"
      ];
    };
    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 10d";
    };
  };

  time.timeZone = "Europe/Monaco";
  i18n = {
    defaultLocale = "en_US.UTF-8";
    supportedLocales = [
      "en_US.UTF-8/UTF-8"
    ];
    extraLocaleSettings = {
      LC_ALL = "";
      LC_ADDRESS = "en_US.UTF-8";
      LC_IDENTIFICATION = "en_US.UTF-8";
      LC_MEASUREMENT = "en_US.UTF-8";
      LC_MONETARY = "en_US.UTF-8";
      LC_NAME = "en_US.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LC_PAPER = "en_US.UTF-8";
      LC_TELEPHONE = "en_US.UTF-8";
      LC_TIME = "en_US.UTF-8";
    };
  };

  powerManagement = {
    enable = true;
    cpuFreqGovernor = "powersave"; # TODO: issues around schedutil/ondemand
  };

  services = {
    thinkfan = {
      enable = true;
      sensors = [
        {
          type = "hwmon";
          query = "/sys/devices/virtual/thermal/thermal_zone0/temp";
        } # pch_cannonlake
        {
          type = "hwmon";
          query = "/sys/devices/virtual/thermal/thermal_zone5/temp";
        } # B0D4
        {
          type = "hwmon";
          query = "/sys/devices/virtual/thermal/thermal_zone7/temp";
        } # x86_pkg_temp (CPU package)
        {
          type = "hwmon";
          query = "/sys/devices/virtual/thermal/thermal_zone9/temp";
        } # acpi thermal zone
      ];
      levels = [
        [0 0 40] # fan off
        [1 40 50] # low fan
        [2 50 60] # medium fan
        [4 60 70] # high fan
        [6 70 80] # higher fan
        [7 80 90] # max fan
        [127 90 32767] # emergency max
      ];
    };

    fprintd.enable = true;
    fwupd.enable = true;
    xserver.xautolock = {
      enable = true;
      locker = "${pkgs.betterlockscreen}/bin/betterlockscreen -l";
      time = 11;
    };

    dbus.enable = true;

    upower = {
      enable = true;
      percentageLow = 15;
      percentageCritical = 7;
      percentageAction = 5;
      criticalPowerAction = "Hibernate";
    };
    undervolt = {
      enable = true;
      package = pkgs.undervolt;
      coreOffset = -120;
      gpuOffset = -120;
      uncoreOffset = -80;
      verbose = true;
      p1 = {
        window = 28;
        limit = 35;
      };

      p2 = {
        window = 3;
        limit = 45;
      };
    };
    tlp = {
      enable = true;
      settings = {
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
        CPU_SCALING_GOVERNOR_ON_AC = "powersave";
        CPU_BOOST_ON_BAT = 0;
        CPU_BOOST_ON_AC = 1;
        DISK_IDLE_SECS_ON_AC = 0;
        DISK_IDLE_SECS_ON_BAT = 2;
        MAX_LOST_WORK_SECS_ON_AC = 15;
        MAX_LOST_WORK_SECS_ON_BAT = 60;
        SCHED_POWERSAVE_ON_AC = 0;
        START_CHARGE_THRESH_BAT0 = 20;
        STOP_CHARGE_THRESH_BAT0 = 80;
        WOL_DISABLE = 1;
        NMI_WATCHDOG = 0;
      };
    };
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
      videoDrivers = ["nvidia"];
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

  nixpkgs.config.nvidia.acceptLicense = true;
  hardware = {
    graphics = {
      enable = true;
    };
    nvidia = {
      modesetting.enable = true;
      powerManagement.enable = false;
      open = true;

      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
      prime = {
        offload = {
          enable = true;
          enableOffloadCmd = true;
        };
        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:1:0:0";
      };
    };
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

  security.pam.services.sudo.fprintAuth = true;
  security.pam.services.sudo.text = ''
    auth sufficient ${pkgs.fprintd}/lib/security/pam_fprintd.so
    auth required pam_unix.so try_first_pass
    account required pam_unix.so
  '';

  users.defaultUserShell = pkgs.nushell;

  users.users.vanishingideal = {
    isNormalUser = true;
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

      xdg-desktop-portal
      xdg-desktop-portal-gtk

      dive
      podman-tui
      podman-compose
      xorg.xhost
      google-chrome
      fwupd
      nvtopPackages.full
      cachix
      (catppuccin-sddm.override {
        flavor = "mocha";
        font = "Jetbrains Mono";
        fontSize = "9";
        loginBackground = true;
      })
    ];
    variables = {
      BROWSER = "brave";
    };

    shellInit = ''
      if [ ! -f "$HOME/.Xauthority" ]; then
        xauth generate :0 . trusted
        touch "$HOME/.Xauthority"
        chmod 600 "$HOME/.Xauthority"
      fi
    '';
  };

  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = [
    (self: super: {
      btop = super.btop.override {cudaSupport = true;};
    })
  ];
  virtualisation = {
    podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true;
      autoPrune.enable = true;
    };
    libvirtd = {
      enable = true;
      package = pkgs.libvirt;
    };
  };

  fonts = {
    fontconfig = {
      antialias = true;
      hinting = {
        enable = true;
        style = "slight";
        autohint = true;
      };
      subpixel = {
        rgba = "rgb";
        lcdfilter = "default";
      };
    };
  };
}
