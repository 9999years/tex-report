{ pkgs ? import <nixpkgs> {} }:
let
  inherit (pkgs) mkShell texlive;
  tex = texlive.combine {
    inherit (texlive) scheme-minimal;
  };
in
mkShell {
  buildInputs = [ tex ];
}
