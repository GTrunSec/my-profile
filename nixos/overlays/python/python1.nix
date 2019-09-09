world:
# python package overrides
self: pkgs:
with pkgs;
{

  bat = buildPythonPackage rec {
    pname = "bat";
    version = "0.3.6";
    name = "${pname}-${version}";
    src = fetchPypi {
      inherit pname version;
      sha256 = "2f8ff566a4d3a92246d367f2e9cd6ed3edeef670dcd6dda6dfdc9efed88bcd80";
    };
    doCheck = false; # broken imports
  };

}
  
