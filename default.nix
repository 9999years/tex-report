{ pkgs ? import <nixpkgs> {} }:
let
  inherit (pkgs) stdenv lib pandoc;

in
stdenv.mkDerivation {
  pname = "tex-report";
  version = "0.0.1";
  src = ./.;
  nativeBuildInputs = [ pandoc ];

  dontConfigure = true;
  dontInstall = true;

  buildPhase = ''
    mkdir -p $out
    pandoc --from markdown \
      --to html \
      ./report.md \
      -o $out/tex-report.html
  '';
}
