{
  packageOverrides = pkgs: {
    texmacs = pkgs.texmacs.override{chineseFonts = true; extraFonts = true;};
    # pandas = pkgs.pandas.overridePythonAttrs (oldAttrs: { checkPhase = "true"; });
  };
  allowUnfree = true;
  allowBroken = true; # intero only?
}
