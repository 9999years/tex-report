{ pkgs ? import <nixpkgs> { } }:
let inherit (pkgs) mkShell;
in mkShell { buildInputs = [ pkgs.watchexec pkgs.pandoc pkgs.just ]; }
