{
  lib,
  clangStdenv,
  pkg-config,
  boost,
  capnproto,

  lixPackageSets,
  the_lix ? lixPackageSets.latest.lix,
}:
clangStdenv.mkDerivation {
  pname = "lix-math";
  version = "0.0.1";

  src = ./.;

  makeFlags = [ "PREFIX=$(out)" ];

  nativeBuildInputs = [ pkg-config ];

  buildInputs = [
    the_lix
    boost
    capnproto
  ];

  meta = {
    description = "adds some cool butilits to lix for maths";
    homepage = "https://github.com/";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ isabelroses ];
  };
}
