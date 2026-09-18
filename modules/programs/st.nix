{ inputs, ... }:

{
  flake-file.inputs.st = {
    url = "github:7zo7zo7zo/st-temp";
    flake = false;
  };

	flake.aspects.st.homeManager = { pkgs, ... }: {
    home.packages = with pkgs; [
      (pkgs.st.overrideAttrs (_: {
        src = inputs.st;
      }))
    ];

    xdg.desktopEntries.st = {
      name = "st";
      genericName = "Terminal";
      comment = "st is a simple terminal implementation for X";

      exec = "st";
      icon = "utilities-terminal";
      terminal = false;
      type = "Application";

      categories = [ "System" "TerminalEmulator" ];

      settings = {
        TryExec = "st";
        StartupWMClass = "st-256color";
      };
    };
  };
}
