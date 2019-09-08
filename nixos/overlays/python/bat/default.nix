{ buildPythonPackage
, fetchPypi
, git
, numpy
, pandas
, watchdog
, requests 
, scikitlearn
, pyarrow
}:

buildPythonPackage rec {

  pname = "bat";
  version = "0.3.5";

  src = fetchPypi {
    inherit pname version;
    sha256 = "12al8c22isy6dygsh7s1f1ac7vipcqyy8rv8clv7salpcm6678w1";
  };
  # src = fetchFromGitHub {
  #   inherit pname
  #   owner = "r9y9";
  #   rev = "$version";
  #   sha256 = "1yjhvakz0ai65i7n4ah5kakfgpp1inz9fghdvchhhl1a1s2scqfp";
  # };

  
  doCheck = false;
  nativeBuildInputs = [ git ];
  propagatedBuildInputs = [
    git
    numpy
    pandas
    watchdog
    requests 
    scikitlearn
    pyarrow
  ];
}
