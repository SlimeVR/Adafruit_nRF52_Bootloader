{
  description = "A very basic Zephyr flake";

  inputs = {
    nixpkgs.url = "nixpkgs";
  };

  outputs = {
    self,
    nixpkgs,
    ...
  }: let
    pkgs = import nixpkgs {
      system = "x86_64-linux";
      config.allowUnfree = true;
      config.segger-jlink.acceptLicense = true;
      config.permittedInsecurePackages = [
        "segger-jlink-qt4-796s"
      ];
    };
  in {
    devShells.x86_64-linux.default = pkgs.mkShell {
      packages = with pkgs; [
        gnumake
        python312Packages.intelhex
        nrf-command-line-tools
        gcc-arm-embedded
        adafruit-nrfutil
        pyocd
      ];
    };
  };
}
