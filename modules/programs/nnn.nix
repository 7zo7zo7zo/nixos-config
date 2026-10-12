{
	flake.aspects = { aspects, ... }: {
		nnn = {
			includes = with aspects; [
				tmux
				xdg
				#scripts
			];

			homeManager = { pkgs, lib, config, ... }: {
				my.scripts = [ "f" ];

				programs.nnn = {
					enable = true;
					package = pkgs.nnn.override {
						withNerdIcons = true;
					};
					quitcd = true;
					bookmarks = {
						d = "~/Documents";
						D = "~/Downloads";
						p = "~/Pictures";
						v = "~/Videos";
						m = "/mnt";
						M = "/run/media/steve"; # TODO: make it so steve is not hardcoded
					};
					plugins = {
						src = (pkgs.fetchFromGitHub {
							owner = "jarun";
							repo = "nnn";
							rev = "v5.2";
							sha256 = "sha256-u+88aDHfOZ6bSkg6ahS6eNZWj2QCwJXKW+8nHR99kic=";
						}) + "/plugins";
						mappings = {
							p = "preview-tui";
							d = "dragdrop";
						};
					};
				};

				home.packages = with pkgs; [
					dragon-drop
					ueberzugpp
					ffmpegthumbnailer
					poppler-utils
					atool
					#libarchive
					p7zip
					bat
					glow
				];

				xdg.desktopEntries.nnn = {
					name = "nnn";
					genericName = "File Manager";
					#exec = "xdg-terminal-exec -- f %f";
          #exec = "xdg-terminal-exec -- ${config.home.homeDirectory}/.local/bin/f %f";
          #exec = "${config.home.homeDirectory}/.local/bin/f %f";
          exec = "f %f";
					terminal = false;
					noDisplay = true;
					mimeType = [
						"inode/directory"
						"application/zip"
						"application/x-zip-compressed"
					];
					categories = [ "System" "FileTools" "FileManager" "ConsoleOnly" ];
				};

				home.sessionVariables = {
					NNN_ARCHIVE = "\\.(7z|a|ace|alz|arc|arj|bz|bz2|cab|cpio|deb|gz|jar|lha|lz|lzh|lzma|lzo|rar|rpm|rz|t7z|tar|tbz|tbz2|tgz|tlz|txz|tZ|tzo|war|xpi|xz|Z|zip)$";
					NNN_TERMINAL = "st";
				};
			};
		};
	};
}
