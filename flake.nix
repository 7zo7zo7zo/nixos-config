# DO-NOT-EDIT. This file was auto-generated using github:denful/flake-file.
# Use `nix run .#write-flake` to regenerate it.
{
  description = "My NixOS/home-manager configurations";

  outputs = inputs: inputs.flake-parts.lib.mkFlake { inherit inputs; } (inputs.import-tree ./modules);

  inputs = {
    dwm = {
      url = "github:7zo7zo7zo/dwm-temp";
      flake = false;
    };
    dwmblocks = {
      url = "github:7zo7zo7zo/dwmblocks";
      flake = false;
    };
    flake-aspects.url = "github:denful/flake-aspects";
    flake-file.url = "github:denful/flake-file";
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    import-tree.url = "github:denful/import-tree";
    nixpkgs.url = "https://channels.nixos.org/nixpkgs-unstable/nixexprs.tar.zst";
    odin-ts-mode = {
      url = "github:Sampie159/odin-ts-mode";
      flake = false;
    };
    st = {
      url = "github:7zo7zo7zo/st-temp";
      flake = false;
    };
  };
}
