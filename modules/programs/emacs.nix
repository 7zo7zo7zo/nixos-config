{ inputs, ... }:
{
  flake-file.inputs.odin-ts-mode = {
    url = "github:Sampie159/odin-ts-mode";
    flake = false;
  };

  flake.aspects.emacs.homeManager = { pkgs, ... }:
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

      extraPackages = epkgs: with epkgs; [
      use-package
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

        (treesit-grammars.with-grammars (grammars: [
          grammars.tree-sitter-c
          grammars.tree-sitter-cpp
          grammars.tree-sitter-odin
        ]))
      ];
    };

    home.packages = with pkgs; [
      ripgrep
      cantarell-fonts
    ];
  };
}
