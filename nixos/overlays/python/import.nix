self: pkgs:
with pkgs;

let gccOpts = {
  langC = true;
  langCC = true;
  langFortran = true;
  langObjC = true;
  langObjCpp = true;
  enableShared = true;
  enableMultilib = false;
    }; in


{

  python = self.python2;
  pythonPackages = self.python.pkgs;
  python2Packages = self.python2.pkgs;
  python3Packages = self.python3.pkgs;

  python3-all = (self.python3.withPackages self.pythonPackageList).override {
    ignoreCollisions = true; # see #31080
  };
  python2-all = (self.python2.withPackages self.pythonPackageList).override {
    ignoreCollisions = true; # see #31080
  };

  python3= python3.override {
    self = self.python3;
    CF = null;
    configd = null;
    packageOverrides = import ./python/python1.nix self;
  };

}
