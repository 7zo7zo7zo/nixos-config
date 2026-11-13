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

      au-themes = {
        url = "github:szymonwilczek/au-themes";
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

    homeManager = { pkgs, config, ... }:
      let
        odin-ts-mode = pkgs.emacsPackages.trivialBuild {
          pname = "odin-ts-mode";
          version = "unstable";
          src = inputs."odin-ts-mode";
        };
        au-themes = pkgs.emacsPackages.trivialBuild {
          pname = "au-themes";
          version = "unstable";
          src = inputs."au-themes";
          packageRequires = with pkgs.emacsPackages; [
            ef-themes
          ];
        };
      in
      {
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
            envrc
            corfu
            cape
            odin-ts-mode
            no-littering
            breadcrumb
            nix-ts-mode
            olivetti
            au-themes
            #ghostel

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
          aporetic

          # Language servers
          nixd
        ];

        xdg.desktopEntries.my-emacs= {
          name = "Emacs (New Tab)";
          exec = "${config.programs.emacs.finalPackage}/bin/emacsclient --no-wait %f";
          terminal = false;
          categories = [ "Development" "TextEditor" ];
          mimeType = [
            "text/plain"
              "text/english"
              "text/x-makefile"
              "text/x-c++hdr"
              "text/x-c++src"
              "text/x-chdr"
              "text/x-csrc"
              "text/x-java"
              "text/x-moc"
              "text/x-pascal"
              "text/x-tcl"
              "text/x-tex"
              "application/x-shellscript"
              "text/x-c"
              "text/x-c++"

              "text/x-nix"
              "application/json"
              "application/xml"
          ];
        };

        xdg.mimeApps = {
          enable = true;
          defaultApplications."text/plain" = "my-emacs.desktop";
        };
      };
  };
}


