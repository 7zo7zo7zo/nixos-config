{
    flake.aspects.godot.homeManager = { pkgs, ... }: {
        home.packages = with pkgs; [
            godot
        ];
    };
}
