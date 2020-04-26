{
  packageOverrides = pkgs: {
    texmacs = pkgs.texmacs.override{chineseFonts = true; extraFonts = true;};
    nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {
      inherit pkgs;
    };
    #julia_13 = pkgs.julia_13.overrideAttrs(oldAttrs: {checkTarget = "";});
    # pandas = pkgs.pandas.overridePythonAttrs (oldAttrs: { checkPhase = "true"; });
  };
  allowUnfree = true;
  allowBroken = true; # intero only?
  permittedInsecurePackages = [
    "openssl-1.0.2u"
  ];
}
