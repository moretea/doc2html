with (import <nixpkgs> {});
let 
  env = bundlerEnv {
    name  ="doc2md-gems";
    gemfile = ./Gemfile;
    lockfile = ./Gemfile.lock;
    gemset = ./gemset.nix;
  }
;
in stdenv.mkDerivation rec {
  name = "doc2html";
  buildInputs = [env.wrappedRuby];

  buildCommand = ''
    mkdir -p $out/bin
    cp ${./exe/doc2html} $out/bin/doc2html
    patchShebangs $out/bin/doc2html
  '';
}
