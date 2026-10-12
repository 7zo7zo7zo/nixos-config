{ inputs, ... }:
{
  flake-file.inputs = {
    nix-doom-emacs-unstraightened = {
      url = "github:marienz/nix-doom-emacs-unstraightened";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    /*
    odin-ts-mode = {
      url = "github:Sampie159/odin-ts-mode";
      flake = false;
    };
    */
  };

  flake.aspects.doom-emacs.homeManager = { pkgs, ... }:
  /*let
    odin-ts-mode = pkgs.emacsPackages.trivialBuild {
      pname = "odin-ts-mode";
      version = "unstable";
      src = inputs."odin-ts-mode";
    };
  in
  */
  {
    imports = [
      inputs.nix-doom-emacs-unstraightened.homeModule
    ];

    programs.doom-emacs = {
      enable = true;

      doomDir = ../../dotfiles/doom;
    };
 
    home.packages = with pkgs; [
      ripgrep
      cantarell-fonts

      # Language servers
      nixd
    ];
  };
}
