{
  mkShellNoCC,
  callPackage,

  # extra tooling
  libcxx,
  gnumake,
  cppcheck,
  clang-tools,
  clang_21,
}:
let
  defaultPackage = callPackage ./package.nix { };
in
mkShellNoCC {
  inputsFrom = [ defaultPackage ];

  packages = [
    libcxx # stdlib for cpp
    gnumake # builder
    cppcheck # static analysis
    clang-tools # fix headers not found
    clang_21
  ];
}
