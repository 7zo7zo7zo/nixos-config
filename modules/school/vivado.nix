{
  flake.aspects.vivado.nixos = {
    services.udev.extraRules = ''
      # Digilent JTAG cables 
      ATTRS{idVendor}=="0403", ATTRS{idProduct}=="6010", MODE="666", GROUP="dialout"
      # Xilinx Platform Cable USB II
      ATTRS{idVendor}=="03fd", ATTRS{idProduct}=="0008", MODE="666", GROUP="dialout"
      ATTRS{idVendor}=="03fd", ATTRS{idProduct}=="0013", MODE="666", GROUP="dialout"
    '';
  };
}
