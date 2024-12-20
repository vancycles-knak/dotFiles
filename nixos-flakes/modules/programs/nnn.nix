{
  username,
  home-manager,
  pkgs,
  ...
}:
{
  # within $home/.config/nnn/plugins
  # sh -c "$(curl -Ls https://raw.githubusercontent.com/jarun/nnn/master/plugins/getplugs)"
  environment.systemPackages = [
    pkgs.xdragon
  ];

  home-manager.users.${username} = {
    programs = {
      nnn = {
        enable = true;
        package = pkgs.nnn.override ({ withNerdIcons = true; });
        plugins.mappings = {
          z = "autojump";
          d = "dragdrop";
          f = "finder";
          o = "fzopen";
          p = "preview-tui";
          c = "fzcd";
          m = "mimelist";
        };
        bookmarks = {
          d = "/home/${username}/Documents";
          D = "/home/${username}/Downloads";
          P = "/home/${username}/Programs";
          p = "/home/${username}/Pictures";
          c = "/home/${username}/Documents/dotFiles/nixos-flakes/";
          m = "/mnt/";
        };
      };
    };
    home = {
      sessionVariables = {
        # NNN_PLUG = "f:finder;o:fzopen;p:preview-tui;t:preview-tabbed"; # tabbed is x only
        NNN_OPTS = "Hedac";
        NNN_TMPFILE = "/tmp/nnn";
        NNN_FIFO = "/tmp/nnn.fifo";
        SPLIT = "v";
        LC_COLLATE = "C";
      };
    };

    programs.fish.functions = {
      n = ''
        nnn -P p
        if test -e $NNN_TMPFILE
                source $NNN_TMPFILE
                rm -rf $NNN_TMPFILE
        end
      '';
    };
  };
}
