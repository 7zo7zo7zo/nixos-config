{
  flake.aspects.tmux.homeManager = { pkgs, ... }: {
    my.dotfiles = [ "tmux" ];

    home.packages = with pkgs; [
      tmux
    ];
  };
}
