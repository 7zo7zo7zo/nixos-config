{
	flake.aspects.ios.nixos = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      libimobiledevice
    ];

    services.usbmuxd = {
      enable = true;
    };
  };
}
