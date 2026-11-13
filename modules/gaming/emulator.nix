{
	flake.aspects.emulator.homeManager = { pkgs, ... }: {
		home.packages = with pkgs; [
			mesen
			#fceux
		];
	};
}
