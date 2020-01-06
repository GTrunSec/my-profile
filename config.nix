{
  packageOverrides = pkgs: {
    texmacs = pkgs.texmacs.override{chineseFonts = true; extraFonts = true;};
  };
  allowUnfree = true;
  allowBroken = true; # intero only?
}
