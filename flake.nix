{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };
  outputs = {nixpkgs, ...}: let
    pkgs = nixpkgs.legacyPackages."x86_64-linux";
  in {
    packages."x86_64-linux".default =
      (import ./default.nix {
        inherit pkgs;
        noDev = true;
      })
      .override {
        executable = true;
      };

    devShells."x86_64-linux".default = pkgs.mkShell {
      nativeBuildInputs = with pkgs; [php81 php81.packages.composer];
    };
  };
}
