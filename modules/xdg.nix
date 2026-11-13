{
	flake.aspects.xdg.homeManager = { config, ... }: {
		xdg = {
			enable = true;
			localBinInPath = true;

			userDirs = {
				enable = true;
				createDirectories = true;
				setSessionVariables = true; # Silence HM 26.05 default change warning

			    desktop     = "${config.home.homeDirectory}/Desktop";
			    documents   = "${config.home.homeDirectory}/Documents";
			    download    = "${config.home.homeDirectory}/Downloads";
			    music       = "${config.home.homeDirectory}/Music";
			    pictures    = "${config.home.homeDirectory}/Pictures";
			    videos      = "${config.home.homeDirectory}/Videos";
			    templates   = "${config.home.homeDirectory}/Templates";
			    publicShare = "${config.home.homeDirectory}/Public";
				projects    = "${config.home.homeDirectory}/Projects";
			};

			terminal-exec = {
				enable = true;
				settings = {
					default = [
						"st.desktop"
					];
				};
			};

			mimeApps = {
				enable = true;
				defaultApplications = {
					"application/pdf" = "org.pwmt.zathura.desktop";

					"image/bmp" = "nsxiv.desktop";
					"image/gif" = "nsxiv.desktop";
					"image/jpg" = "nsxiv.desktop";
					"image/png" = "nsxiv.desktop";
					"image/x-tga" = "nsxiv.desktop";
					"image/webp" = "nsxiv.desktop";
					"image/heic" = "nsxiv.desktop";
					"image/svg+xml" = "nsxiv.desktop";

					"video/mkv" = "mpv.desktop";
					"video/quicktime" = "mpv.desktop";
					"video/mp4" = "mpv.desktop";
					"video/webm" = "mpv.desktop";

					"inode/directory" = "nnn.desktop";
					"application/zip" = "nnn.desktop";
					"application/x-zip-compressed" = "nnn.desktop";

					"text/html" = "firefox.desktop";
					"application/xhtml+xml" = "firefox.desktop";
					"x-scheme-handler/http" = "firefox.desktop";
					"x-scheme-handler/https" = "firefox.desktop";

					"text/markdown" = "my-emacs.desktop";
					"text/x-markdown" = "my-emacs.desktop";
          "text/x-log" = "my-emacs.desktop";
				};
			};
		};
	};
}
