{
	flake.aspects.java.homeManager = { pkgs, ... }: {
    home.packages = with pkgs; [
      jetbrains.idea
    ];
	};
}
