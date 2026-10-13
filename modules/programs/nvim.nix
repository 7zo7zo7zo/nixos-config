{
  flake.aspects.nvim.homeManager = { pkgs, ... }: {
    my.dotfiles = [ "nvim" ];

    home.packages = with pkgs; [
      neovim
      tree-sitter
    ];
  };
}
