{ inputs, config, lib, ... }:

{
  options.my.hosts = lib.mkOption {
    default = {};

    type = lib.types.attrsOf (lib.types.submodule {
      options = {
        module = lib.mkOption {
          type = lib.types.singleLineStr;
          description = "Name of the host aspect";
        };

        system = lib.mkOption {
          type = lib.types.singleLineStr;
          default = "x86_64-linux";
        };

        primaryUser = lib.mkOption {
          type = lib.types.singleLineStr;
        };

        hardware = lib.mkOption {
          type = lib.types.path;
        };

        stateVersion = lib.mkOption {
          type = lib.types.singleLineStr;
        };
      };
    });
  };

  config.flake.nixosConfigurations = lib.mapAttrs (name: host:
    inputs.nixpkgs.lib.nixosSystem {
      system = host.system;

      modules = [
        config.flake.modules.nixos.${host.module}
        host.hardware

        {
          networking.hostName = name;
          system.stateVersion = host.stateVersion;
          primaryUser = host.primaryUser;

          home-manager.users.${host.primaryUser} = {
            imports = [
              # config.flake.modules.homeManager.${host.module}
              config.flake.aspects.${host.module}.modules.homeManager
            ];

            home.stateVersion = lib.mkDefault host.stateVersion;
          };
        }
      ];
    }
  ) config.my.hosts;

  config.flake.aspects = { aspects, ... }: {
    host = {
      includes = [ aspects.user ];

      nixos = {
        imports = [
          inputs.home-manager.nixosModules.home-manager
        ];

        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
        };
      };
    };
  };
}
