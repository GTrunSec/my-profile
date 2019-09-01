self: super:
let
  overridePython = pypkgs: let
    pyDir = ../overlays/python;
    packageOverrides = pyself: pysuper: (builtins.foldl'
      (acc: item: acc // {
        "${item}" = pysuper.callPackage (pyDir + ("/" + item)) {};
      })
      { }
      (builtins.attrNames (builtins.readDir pyDir)));

  in pypkgs.override { inherit packageOverrides; };
in {
  python37 = overridePython super.python37;
}
