self: super:
# Within the overlay we use a recursive set, though I think we can use `self` as well.
rec {
  # nix-shell -p python.pkgs.my_stuff
  python = super.python.override {
    # Careful, we're using a different self and super here!
    packageOverrides = self: super: {
      my_stuff = super.buildPythonPackage rec {
        pname = "pyaes";
        version = "1.6.0";
        name = "${pname}-${version}";
        src = super.fetchPypi {
          inherit pname version;
          sha256 = "0bp9bjqy1n6ij1zb86wz9lqa1dhla8qr1d7w2kxyn7jbj56sbmcw";
        };
      };
    };
  };
  # nix-shell -p pythonPackages.my_stuff
  pythonPackages = python.pkgs;

  # nix-shell -p my_stuff
  my_stuff = pythonPackages.buildPythonPackage rec {
    pname = "pyaes";
    version = "1.6.0";
    name = "${pname}-${version}";
    src = pythonPackages.fetchPypi {
      inherit pname version;
      sha256 = "0bp9bjqy1n6ij1zb86wz9lqa1dhla8qr1d7w2kxyn7jbj56sbmcw";
    };
  };
}
