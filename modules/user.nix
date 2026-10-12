{
  flake.aspects.user =
  {
    nixos = {pkgs, config, lib, ...}: {
      options.primaryUser = lib.mkOption {
        type = lib.types.singleLineStr;
        default = "";
        description = "Primary user for this NixOS host";
      };

      config = {
        programs.zsh.enable = true;

        nix.settings.trusted-users = [
          "root"
          config.primaryUser
        ];

        users.users.${config.primaryUser} = {
          isNormalUser = true;
          home = "/home/${config.primaryUser}";
          shell = pkgs.zsh;
          extraGroups = [ "wheel" "audio" "video" ];
        };
      };
    };
  };
}
