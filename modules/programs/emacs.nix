{ inputs, ... }:
{
  flake-file = {
    nixConfig = {
      extra-trusted-public-keys = [ "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs=" ];
      extra-substituters = [ "https://nix-community.cachix.org" ];
    };

    inputs = {
      emacs-overlay = {
        url = "github:nix-community/emacs-overlay";
        inputs.nixpkgs.follows = "nixpkgs";
      };

      odin-ts-mode = {
        url = "github:Sampie159/odin-ts-mode";
        flake = false;
      };
    };
  };

  flake.aspects.emacs = {
    nixos = {
      nixpkgs.overlays = [
        inputs.emacs-overlay.overlays.default
      ];
    };

    homeManager = { pkgs, ... }:
    let
      odin-ts-mode = pkgs.emacsPackages.trivialBuild {
        pname = "odin-ts-mode";
        version = "unstable";
        src = inputs."odin-ts-mode";
      };
    in {
      my.dotfiles = [ "emacs" ];

      programs.emacs = {
        enable = true;
        package = pkgs.emacs-gtk;

        extraPackages = epkgs: with epkgs; [
          #command-log-mode
          vertico
          consult
          marginalia
          doom-modeline
          doom-themes
          #helpful
          evil
          evil-collection
          orderless
          org-roam
          magit
          org-bullets
          visual-fill-column
          envrc
          corfu
          cape
          odin-ts-mode
          no-littering
          breadcrumb
          nix-ts-mode

          (treesit-grammars.with-grammars (grammars: [
            grammars.tree-sitter-c
            grammars.tree-sitter-cpp
            grammars.tree-sitter-odin
            grammars.tree-sitter-nix
          ]))
        ];
      };
   
      home.packages = with pkgs; [
        ripgrep
        cantarell-fonts

        # Language servers
        nixd
      ];
    };
  };
}

 
