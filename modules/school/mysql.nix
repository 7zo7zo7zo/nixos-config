{
    flake.aspects.mysql = {
        nixos = { pkgs, ... }: {
            services.mysql = {
                enable = true;
                package = pkgs.mysql84;
            };

            services.gnome.gnome-keyring.enable = true;
            services.xserver.updateDbusEnvironment = true;
        };

        homeManager = { pkgs, ... }: {
            # Fix Python compatibility with MySQL Workbench.
            home.file.".local/share/mysql-workbench-python/lib/python3.14/site-packages/pipes.py".text = ''
                from shlex import quote
                '';

            home.packages = with pkgs; [
                mysql_jdbc

                (writeShellScriptBin "mysql-workbench" ''
                    export PYTHONUSERBASE="$HOME/.local/share/mysql-workbench-python"
                    unset PYTHONNOUSERSITE

                    exec ${mysql-workbench}/bin/mysql-workbench "$@"
                '')
            ];
        };
    };
}
