# home.nix
# home-manager switch

{ config, pkgs, ... }:

{
  imports = [
    ../../home-modules/programs/nnn.nix
    ../../home-modules/programs/kitty.nix
    ../../home-modules/programs/starship.nix
    ../../home-modules/programs/lazygit.nix
    ../../home-modules/programs/modern_unix.nix
    ../../home-modules/programs/fzf.nix
    ../../home-modules/programs/btop.nix
    ../../home-modules/programs/fish.nix
    ../../home-modules/programs/zsh.nix
    ../../home-modules/programs/nushell.nix
    ../../home-modules/programs/keychain.nix
    ../../home-modules/programs/spacemacs.nix
    ../../home-modules/programs/git.nix
    ../../home-modules/programs/vim.nix
    ../../home-modules/programs/devops.nix
    ../../home-modules/programs/spotify.nix
    ../../home-modules/programs/nh.nix
    # languages
    ../../home-modules/languages/nix.nix
    ../../home-modules/languages/python.nix
    ../../home-modules/languages/jsts.nix
    ../../home-modules/languages/bash.nix
    # services
    # ./home-modules/services/appleTouchId.nix

  ];
  home.username = "henri.vandersleyen";
  home.homeDirectory = "/Users/henri.vandersleyen";
  home.stateVersion = "23.05"; # Please read the comment before changing.

  # Makes sense for user specific applications that shouldn't be available system-wide
  home.packages = [ ];

  home.file = { };

  home.sessionVariables = {

    # for nh
    FLAKE = "~/Documents/dotFiles/nix-darwin";
  };

  home.sessionPath = [
    "/run/current-system/sw/bin"
    "$HOME/.nix-profile/bin"
  ];
  programs.home-manager.enable = true;
  # shells

  # theme
  catppuccin.flavor = "mocha";
  catppuccin.enable = true;
}
