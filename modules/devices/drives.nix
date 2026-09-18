{
	flake.aspects.drives.nixos = {
		boot.supportedFilesystems = [ "exfat" ];

		fileSystems."/mnt/storage" = {
			device = "/dev/disk/by-uuid/8810-72D0";
			fsType = "exfat";
			options = [
				"nofail"
				"x-systemd.automount"
				"x-systemd.device-timeout=5s"

				# Make exFAT files owned by your normal user
				# Verify with `id`
				"uid=1000"
				"gid=100"
				"umask=0022"
			];
		};

		fileSystems."/mnt/work" = {
			device = "/dev/disk/by-uuid/a2579941-d7c5-49b9-a2ad-a0859b962991";
			fsType = "ext4";
			options = [
				"nofail"
				"x-systemd.automount"
				"x-systemd.device-timeout=5s"
			];
		};
	};
}
