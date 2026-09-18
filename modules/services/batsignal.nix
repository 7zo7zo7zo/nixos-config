{
	flake.aspects.batsignal.homeManager = { pkgs, ... }: {
    services.batsignal = {
      enable = true;
      extraArgs = [
        "-n"
        "BAT1"
        "-m"
        "30"
        "-p"
      ];
    };
	};
}
