let
  pkgs =
    import (builtins.fetchTarball {
      url = "https://github.com/NixOS/nixpkgs/archive/0c924ab22aa8818c701ad9d94be34dc7934d692c.tar.gz";
      sha256 = "1llhad9y24bqp7ib8ls2fwk4jpqakyrzhy7p2djkqlbsnhzcvd1q";
    }) {};
in
pkgs.mkShell {
  nativeBuildInputs = [
    pkgs.haskell.compiler.ghc90
    pkgs.cabal-install
    pkgs.zlib.dev
  ];
}
