{ ... }:

{
    flake.aspects = { aspects, ... }: {
        exwm = {
            includes = with aspects; [ x11 ];

            nixos = { ... }: {
                services.xserver = {
                    enable = true;
                    displayManager.startx.enable = true;
                };
            };

            homeManager = { config, ... }: {
                programs.emacs.extraPackages = epkgs: [
                    epkgs.exwm
                ];

                xsession = {
                    enable = true;

                    windowManager.command = ''
                        ${config.programs.emacs.finalPackage}/bin/emacs \
                        --eval '(require (quote exwm))' \
                        --eval '(exwm-wm-mode 1)'
                        '';
                };

                home.sessionVariables.XINITRC =
                    "${config.xdg.configHome}/X11/xinitrc";

                xdg.configFile."X11/xinitrc" = {
                    executable = true;
                    text = ''
                        exec "$HOME/.xsession"
                        '';
                };

                programs.zsh = {
                    enable = true;
                    loginExtra = ''
                        if [[ "$(tty)" = "/dev/tty1" && -z "$DISPLAY" ]]; then
                            startx "$XINITRC"
                                fi
                                '';
                };
            };
        };
    };
}
