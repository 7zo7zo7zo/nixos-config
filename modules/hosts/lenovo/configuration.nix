{ inputs, ... }:

{
	flake = {
		aspects = { aspects, ... }: {
			host-lenovo = let
				primaryUser = "steve";
			in {
				description = "Configuration for my Lenovo IdeaPad 130-15AST";

				includes = with aspects; [
					base
					user
					zsh
					dwm
					audio
					bluetooth
					printing	
					xdg
					nvim
					passwords
					st
					firefox
					obsidian
					mpv
					nsxiv
					zathura
					tmux
					nnn
					syncthing
					fastfetch
          batsignal
				];

				nixos = {config, pkgs, ...}: {
					imports = [
						./_hardware-configuration.nix
						inputs.home-manager.nixosModules.home-manager
					];

					# Fix broken and duplicate Lid Switch and Power Button -- TODO: fix Power Button better (still shows up on evtest)
					services.udev.extraRules = ''
						ACTION=="add", SUBSYSTEM=="platform", KERNEL=="PNP0C0D:00", DRIVER=="acpi-button", \
						RUN+="${pkgs.runtimeShell} -c 'echo PNP0C0D:00 > /sys/bus/platform/drivers/acpi-button/unbind && echo PNP0C0D:01 > /sys/bus/platform/drivers/acpi-button/bind'"

						SUBSYSTEM=="input", KERNELS=="PNP0C0C:00", TAG-="power-switch"
					'';

					services.picom = {
						enable = true;
						backend = "xrender";
						vSync = true;

						fade = false;
						shadow = false;
						inactiveOpacity = 1.0;
					};

					services.udisks2.enable = true;

					environment.localBinInPath = true;

					networking.hostName = "lenovo";
					system.stateVersion = "25.11";
					inherit primaryUser;

					home-manager = {
						useGlobalPkgs = true;
						useUserPackages = true;

						users.${config.primaryUser} = {
							imports = [ aspects.host-lenovo.modules.homeManager ];
						};
					};
				};

				homeManager = { pkgs, ... }: {
					home.stateVersion = "25.11";
					inherit primaryUser;

					home.packages = with pkgs; [
						pavucontrol
						# gimp
						# krita
						# screenkey
					];

					services.udiskie = {
						enable = true;
					};

					home.sessionVariables = {
						TERMINAL = "st";
						BROWSER = "firefox";
						EDITOR = "nvim";
						VISUAL = "nvim";
						PAGER = "less";
					};
				};
			};
		};

		nixosConfigurations.lenovo = inputs.nixpkgs.lib.nixosSystem {
			system = "x86_64-linux";

			modules = [ inputs.self.modules.nixos.host-lenovo ];
		};
	};
}
