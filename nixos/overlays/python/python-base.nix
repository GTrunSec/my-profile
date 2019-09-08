{ pkgs, fetchurl, fetchgit, fetchhg }:

self: super:
{
  "bat" = super.buildPythonPackage rec {
    pname = "bat";
    version = "0.3.6";
    src = super.fetchurl {
      url = "https://files.pythonhosted.org/packages/b3/21/1542230e50d193e14e9b5b71c159b6f4d38e42e57403acf08fabc1497e9c/bat-0.3.6.tar.gz";
      sha256 = "12cf0ygpz9srpfh9gx2f9ba0swa1rzypv3sm4r0hmjyw6b4nm2w0";
              };
    format = "setuptools";
    doCheck = false;
    buildInputs = [];
    checkInputs = [];
    nativeBuildInputs = [];
    propagatedBuildInputs = [];
  };
}
