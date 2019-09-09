{ buildPythonPackage
, fetchPypi
, git
, numpy
, pandas
, watchdog
, requests 
, scikitlearn
, pyarrow
, matplotlib 
}:

buildPythonPackage rec {

  pname = "bat";
  version = "0.3.6";

  src = fetchPypi {
    inherit pname version;
    sha256 = "13i7mqg14zp63d52lckslvzgxi75div7864rd1m56dqyc4kwxq7d";
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
    matplotlib
  ];
}
