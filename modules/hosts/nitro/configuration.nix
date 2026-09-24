{ inputs, ... }:

{
	flake = {
		aspects = { aspects, ... }: {
			host-nitro = let
				primaryUser = "steve";
			in {
				description = "Configuration for my Acer Nitro 5 AN515-54";

				includes = with aspects; [
					base
					user
					zsh
					drives
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
					minecraft
					office
					doom
					#steam
					#emulator
					direnv
          vivado
          batsignal
          emacs
          #ios
          java
				];

				nixos = {config, pkgs, ...}: {
					imports = [
						./_hardware-configuration.nix
						inputs.home-manager.nixosModules.home-manager
					];

					# cat /proc/driver/nvidia/gpus/0000:01:00.0/power
					# Runtime D3 status:          Enabled (fine-grained)
					boot.kernelParams = [
						"nvidia.NVreg_EnableGpuFirmware=0"
						#"nvidia.NVreg_DynamicPowerManagement=0x02"
						#"nvidia.NVreg_PreserveVideoMemoryAllocations=1"
            "nvidia-drm.fbdev=0" # Fixes HDMI hotplug events
					];

					hardware.graphics = {
						enable = true;
					};

					services.xserver.videoDrivers = [ "nvidia" ];

					hardware.nvidia = {
						modesetting.enable = true;
						powerManagement.enable = true; # Needed for suspend to work?
						powerManagement.finegrained = true;
						open = false;
						nvidiaSettings = true;

						package = config.boot.kernelPackages.nvidiaPackages.stable;

						prime = {
							offload = {
								enable = true;
								enableOffloadCmd = true;
							};

							intelBusId = "PCI:0:2:0";
							nvidiaBusId = "PCI:1:0:0";
            };
          };

          services.udev.extraHwdb = ''
            evdev:atkbd:*
              KEYBOARD_KEY_3a=esc

            evdev:input:b*v*p*
              KEYBOARD_KEY_70039=esc
          '';

          environment.systemPackages = with pkgs; [
            libinput
					];

          environment = {
            etc = {
              "libinput/local-overrides.quirks".text = ''
                [Never Debounce]
                MatchUdevType=mouse
                ModelBouncingKeys=1
              '';
            };
          };

					services.libinput.enable = true;

					services.picom = {
						enable = true;
						backend = "glx";
						vSync = false;

						fade = false;
						shadow = false;
						inactiveOpacity = 1.0;
					};

          services.autorandr = {
            enable = true;
            matchEdid = true;

            profiles = {
              laptop = {
                fingerprint = {
                  eDP-1 = "00ffffffffffff0009e5180800000000201c0104a522137802c9a0955d59942924505400000001010101010101010101010101010101953b803671383c403020360058c21000001a000000000000000000000000000000000000000000fe00424f452043510a202020202020000000fe004e5631353646484d2d4e34380a0049";
                };

                config = {
                  eDP-1 = {
                    enable = true;
                    primary = true;
                    mode = "1920x1080";
                    rate = "60.00";
                    position = "0x0";
                  };

                  HDMI-1-0.enable = false;
                };
              };

              external = {
                fingerprint = {
                  eDP-1 = "00ffffffffffff0009e5180800000000201c0104a522137802c9a0955d59942924505400000001010101010101010101010101010101953b803671383c403020360058c21000001a000000000000000000000000000000000000000000fe00424f452043510a202020202020000000fe004e5631353646484d2d4e34380a0049";
                  HDMI-1-0 = "00ffffffffffff0022f08331010101012a1b010380301b782a43f5a756539c26105054a10800d1c081c0a9c0b3009500818081000101023a801871382d40582c4500dc0c1100001e000000fd00323c1e5011000a202020202020000000fc0048502032326377610a20202020000000ff0036434d373432305854350a202001bf020319b149901f0413030212110167030c0010000022e2002b023a801871382d40582c4500dc0c1100001e023a80d072382d40582c4500dc0c1100001e000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000f7";
                };

                config = {
                  eDP-1.enable = false;

                  HDMI-1-0 = {
                    enable = true;
                    primary = true;
                    mode = "1920x1080";
                    rate = "60.00";
                    position = "0x0";
                  };
                };
              };
            };
          };

					services.udisks2.enable = true;

					environment.localBinInPath = true;

					networking.hostName = "nitro";
					system.stateVersion = "26.05";
					inherit primaryUser;

					home-manager = {
						useGlobalPkgs = true;
						useUserPackages = true;

						users.${config.primaryUser} = {
							imports = [ aspects.host-nitro.modules.homeManager ];
						};
					};
				};

				homeManager = { pkgs, ... }: {
					home.stateVersion = "26.05";
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

		nixosConfigurations.nitro = inputs.nixpkgs.lib.nixosSystem {
			system = "x86_64-linux";

			modules = [ inputs.self.modules.nixos.host-nitro ];
		};
	};
}
