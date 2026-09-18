{
  flake.aspects.emacs.homeManager = { pkgs, ... }: {
    programs.emacs = {
      enable = true;

      extraPackages = epkgs: with epkgs; [
      use-package
        #command-log-mode
        vertico
        consult
        marginalia
        doom-modeline
        doom-themes
        #rainbow-delimiters
        #helpful
        evil
        evil-collection
        projectile
        orderless
        org-roam
        magit
        org-bullets
        visual-fill-column
      ];
    };

		home.packages = with pkgs; [
			ripgrep
      cantarell-fonts
		];
  };
}
