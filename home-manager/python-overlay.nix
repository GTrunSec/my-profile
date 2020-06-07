self: super:
# Within the overlay we use a recursive set, though I think we can use `self` as well.
rec {
  python3 = super.python3.override {
    packageOverrides = selfPythonPackages: pythonPackages: {
      astroid = pythonPackages.astroid.overridePythonAttrs (oldAttrs: {
        src = super.fetchPypi {
          pname = "astroid";
          version = "2.4.1";
          sha256 = "71ea07f44df9568a75d0f354c49143a4575d90645e9fead6dfb52c26a85ed13f";
        };
      });
    };
  };
}
