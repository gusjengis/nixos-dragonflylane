{
  config,
  lib,
  inputs,
  pkgs,
  stable,
  ...
}:
{
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };

  services.xserver.videoDrivers = [
    "amdgpu"
    "modesetting"
  ];

  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
    };
  };

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  services.gnome.gnome-keyring.enable = true;

  security.pam.services = {
    login.enableGnomeKeyring = true;
    gdm.enableGnomeKeyring = true; # or sddm, etc.
  };

  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.enable = true;
  boot.loader.grub.enable = false;
  boot.loader.timeout = 1;
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  services.getty.autologinUser = "dragonflylane"; # Positano3#
  services.gvfs.enable = true;
  services.udisks2.enable = true;
  time.timeZone = "America/Los_Angeles";
  fonts.packages = with pkgs; [
    cozette
    carlito
    commit-mono
    nerd-fonts.meslo-lg
    fragment-mono
    helvetica-neue-lt-std
  ];

  networking.hostName = "dragonflylane";
  networking.networkmanager.enable = true;
  nixpkgs.config.allowBroken = true;
  # Turn of password for sudo, so annoying
  security.sudo.extraConfig = ''
    %wheel ALL=(ALL) NOPASSWD: ALL
  '';
  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
  nixpkgs.config.allowUnfree = true;
  systemd.services."NetworkManager-wait-online".enable = false;
  environment.systemPackages = with pkgs; [
    wayland
    vulkan-loader
    egl-wayland
    libgbm
    libglvnd
    wayland-protocols
    libxkbcommon
    libGL
    skia
    kitty
    neovim
    nixfmt
    wl-clipboard
    ripgrep
    fzf
    gcc
    gnumake
    rustup
    cargo
    git
    gh
    lazygit
  ];

  programs.dconf.enable = true;
  services.avahi.publish.enable = true;
  services.avahi.publish.userServices = true;
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  xdg.portal.enable = true;
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  services.gnome.core-apps.enable = false;

  users.users.dragonflylane = {
    isNormalUser = true;
    description = "Beth Green";
    extraGroups = [
      "networkmanager"
      "wheel"
      "dialout"
    ];
    packages = with pkgs; [ home-manager ];
  };

  services.fwupd.enable = true;

  boot.kernelParams = [
    "processor.max_cstate=5"
    "idle=nomwait"
    "acpi.ec_no_wakeup=1"
    "thinkpad-acpi"
  ];

  services.tlp.enable = true;
  services.power-profiles-daemon.enable = false;

  powerManagement.enable = true;
  hardware.enableRedistributableFirmware = true;

  system.stateVersion = "25.11"; # DON'T CHANGE THIS

  services.keyd = {
    enable = true;

    keyboards = {
      default = {
        extraConfig = ''
          	[ids]
          		0002:000a:83b21bac
          	[main]
          		middlemouse = leftmeta
        '';
      };
    };
    # keyboards.trackpoint = {
    #   ids = [ "TPPS/2 Elan TrackPoint" ];

    #   settings = {
    #     main = {
    #       middlemouse = "leftmeta";
    #     };
    #   };
    # };
  };
  services.upower.enable = true;
}
