{ inputs, ... }:

{
  flake-file.inputs = {
    #flake-parts.url = "github:hercules-ci/flake-parts";
    #flake-file.url = "github:denful/flake-file";
    flake-aspects.url = "github:denful/flake-aspects";
    #import-tree.url = "github:denful/import-tree";
  };

	imports = [
		#inputs.flake-parts.flakeModules.modules
    #inputs.flake-file.flakeModules.default
    inputs.flake-file.flakeModules.dendritic # Also includes nixpkgs and systems: https://github.com/denful/flake-file/tree/main/modules/dendritic
		inputs.flake-aspects.flakeModule
	];

  # Import all modules recursively with import-tree
  #flake-file.outputs = ''
  #  inputs: inputs.flake-parts.lib.mkFlake { inherit inputs; } (inputs.import-tree ./modules)
  #'';

  # Set flake.systems
	#systems = [
	#	"x86_64-linux"
	#];
}
