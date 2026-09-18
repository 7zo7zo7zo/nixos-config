{
	flake.aspects = { aspects, ... }: {
		nvim = {
			includes = with aspects; [ dotfiles ];

			homeManager = { pkgs, ... }: {
				my.dotfiles = [ "nvim" ];

				home.packages = with pkgs; [
					neovim
          tree-sitter
				];
			};
		};
	};
}
