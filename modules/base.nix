{ inputs, ... }:

{
  flake-file = {
    description = "My NixOS/home-manager configurations";

    inputs = {
      home-manager = {
        url = "github:nix-community/home-manager";
        inputs.nixpkgs.follows = "nixpkgs";
      };
    };
  };

	flake.aspects.base = {
		nixos = { pkgs, ... }: {
			# =========================================================================
			# Bootloader
			# =========================================================================
			boot.loader = {
				efi = {
					canTouchEfiVariables = true;
					efiSysMountPoint = "/boot";
				};
				grub = {
					enable = true;
					efiSupport = true;
					device = "nodev";
					useOSProber = true;
				};
			};

			# =========================================================================
			# Kernel
			# =========================================================================
			boot.kernelPackages = pkgs.linuxPackages_latest;
			#boot.kernelParams = [ ''acpi_osi="Windows 2015"'' ];

			# =========================================================================
			# Networking
			# =========================================================================
			networking.networkmanager.enable = true;

			# =========================================================================
			# Time zone
			# =========================================================================
			time.timeZone = "America/Los_Angeles";

			# Allow unfree packages
			nixpkgs.config.allowUnfree = true;

			# Enable flakes and nix command globally
			nix.settings.experimental-features = [
				"nix-command"
				"flakes"
			];

			environment.systemPackages = with pkgs; [
				vim
				neovim
				htop
				file
				psmisc # killall
				wget
				curl
				git
				tree
				usbutils # lsusb
				pciutils # lspci
				evtest
				zip
				unzip
				unrar
				just
			];

			# Some programs need SUID wrappers, can be configured further or are
			# started in user sessions.
			#programs.mtr.enable = true;
			#programs.gnupg.agent = {
			#  enable = true;
			#  enableSSHSupport = true;
			#};

			# =========================================================================
			# OpenSSH
			# =========================================================================
			services.openssh.enable = true;

			# Disable askpass
			programs.ssh.enableAskPassword = false;
		};

		homeManager = {
			home.shellAliases = {
				wget = "wget --hsts-file=$XDG_DATA_HOME/wget-hsts";
			};
		};
	};
}
