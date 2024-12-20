{
  home-manager,
  username,
  pkgs,
  inputs,
  ...
}:
{
  home-manager.users.${username} = {
    imports = [ inputs.nixvim.homeManagerModules.nixvim ];
    programs.nixvim = {
      globals.mapleader = " "; # Sets the leader key to space
      enable = true;
      colorschemes.catppuccin.enable = true;
      plugins = {
        web-devicons.enable = true;
        telescope = {
          enable = true;
        };
        which-key = {
          enable = true;
          # settings.spec = {
          #   "<leader>p" = "Telescope";
          # };
        };
        lightline.enable = true;
        # git
        lazygit.enable = true;
        # languages
        lsp = {
          enable = true;

          servers = {

            ts_ls = {
              enable = true;
            };

            lua_ls = {
              enable = true;
              settings.telemetry.enable = false;
            };
          };
        };
      };
    };
  };
}
