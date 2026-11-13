{
  flake.aspects.qemu.nixos = { config, pkgs, ... }: {
    programs.virt-manager.enable = true;

    virtualisation = {
      libvirtd = {
        enable = true;

        qemu = {
          swtpm.enable = true;

          vhostUserPackages = with pkgs; [
            virtiofsd
          ];
        };
      };

      spiceUSBRedirection.enable = true;
    };

    users.users.${config.primaryUser}.extraGroups = [
      "libvirtd"
    ];

    environment.systemPackages = with pkgs; [
      dnsmasq
    ];
  };
}
