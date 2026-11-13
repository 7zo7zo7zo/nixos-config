{
  flake.aspects.fastfetch.homeManager = { pkgs, ... }: {
    my.dotfiles = [ "fastfetch" ];

    home.packages = with pkgs; [
      (fastfetch.override {
       extraRuntimeDependencies = [ elfutils ];
      })
    ];
  };
}
