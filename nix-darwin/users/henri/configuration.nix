{
  pkgs,
  inputs,
  username,
  hostname,
  hosts,
  ...
}:
{
  imports = [
    hosts.nixosModule
    ../../hosts
    # programs
    ../../nix-modules/programs
    # services
    ../../nix-modules/services
    ../../nix-modules/services/sound.nix
    ../../nix-modules/services/internationalisation.nix
    # local
    ./sops.nix
  ];
  docker.enable = true;
  transmission.enable = true;
  gaming.enable = true;
  yubico.enable = true;
  yubico.keyID = "24978052"; # TODO: add in nix-sops
  nix.settings.experimental-features = "nix-command flakes";
  # Optimize storage and automatic scheduled GC running
  # If you want to run GC manually, use commands:
  # `nix-store --optimize` for finding and eliminating redundant copies of identical store paths
  # `nix-store --gc` for optimizing the nix store and removing unreferenced and obsolete store paths
  # `nix-collect-garbage -d` for deleting old generations of user profiles
  nix.optimise.automatic = true;
  nix.gc = {
    automatic = true;
    # interval = "weekly";
    options = "--delete-older-than 14d";
  };
  # system.configurationRevision = self.rev or self.dirtyRev or null;
  # system.stateVersion = 5;
  nixpkgs.hostPlatform = "x86_64-linux";
  nixpkgs.config.allowUnfree = true;

  programs.fish.enable = true;

  networking = {
    networkmanager.enable = true;
    hostName = "${hostname}"; # because we use nh os switch ensure the flakes +

    stevenBlackHosts = {
      enable = true;
      blockFakenews = true;
      blockGambling = true;
    };
  };
  users.users.${username} = {
    home = "/home/henri";
    shell = pkgs.fish;
    isNormalUser = true;
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
      "audio"
    ];
  };

  environment.systemPackages = with pkgs; [
    cachix
    spotify
  ];

  nix.settings = {
    substituters = [ "https://hyprland.cachix.org" ];
    trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
  };

  home-manager.backupFileExtension = "backup";

  # nix.configureBuildUsers = true;
  # nix.useDaemon = true;
  # services.nix-daemon.enable = true;

  nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ]; # for nix.nix
  # fonts.enableFontDir = true;
  fonts.packages = with pkgs; [
    jetbrains-mono
    nerd-font-patcher
    recursive
  ];

  environment.variables = {
    MOZ_ENABLE_WAYLAND = "1"; # For Firefox, similar for other apps
    NIXOS_OZONE_WL = "1";
    GDK_BACKEND = "wayland";
    WLR_NO_HARDWARE_CURSORS = "1";
    # XDG_CONFIG_HOME = "/users/henri.vandersleyen"; # issue with nushell
  };
  programs.hyprland = {
    enable = true;
    # set the flake package
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    # make sure to also set the portal package, so that they are in sync
    portalPackage =
      inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };
  services = {
    openssh = {
      enable = false;
    };
    displayManager = {
      autoLogin = {
        enable = true;
        user = "${username}";
      };
    };
    xserver = {
      enable = true;
      displayManager = {
        gdm = {
          enable = true;
          wayland = true;
        };
      };
    };
  };
  security.sudo.extraConfig = ''
    Defaults        timestamp_timeout=3600
  '';

  xdg.mime = {
    defaultApplications = {
      "application/pdf" = [ "zathura.desktop" ];
      "application/json" = [ "nvim.desktop" ]; # You'll need a .desktop file for Vim or your preferred editor
      "text/plain" = [ "nvim.desktop" ];
      # Video formats
      "video/mp4" = [ "vlc.desktop" ];
      "video/mpeg" = [ "vlc.desktop" ];
      "video/x-matroska" = [ "vlc.desktop" ];
      "video/quicktime" = [ "vlc.desktop" ];
      "video/x-msvideo" = [ "vlc.desktop" ]; # AVI
      "video/webm" = [ "vlc.desktop" ];
      # Directories
      "inode/directory" = [ "thunar.desktop" ];
      # Images
      # "image/jpeg" = [ "feh.desktop" ];
      # "image/png" = [ "feh.desktop" ];
      # "image/gif" = [ "feh.desktop" ];
      # audio
      "audio/mpeg" = [ "vlc.desktop" ];
      "audio/flac" = [ "vlc.desktop" ];
    };
  };
}
