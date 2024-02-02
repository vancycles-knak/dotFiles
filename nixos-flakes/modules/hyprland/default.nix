{ username, home-manager, pkgs, ... }:
let
  dotfiles_dir = /home/henri/Documents/dotFiles;
in

{
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  home-manager.users.${username} = {
    home = {
      packages = with pkgs; [
        sway
        swww
        xdg-desktop-portal-hyprland
        wl-clipboard
      ];
      file = {
        ".config/hypr/hyprland.conf".source = "${dotfiles_dir}/.config/hypr/hyprland.conf";
        ".config/hypr/mocha.conf".source = "${dotfiles_dir}/.config/hypr/mocha.conf";
        ".config/hypr/start.sh".source = "${dotfiles_dir}/.config/hypr/start.sh";
      };
    };
  };
}