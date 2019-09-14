{ stdenv
, python3Packages
, fetchurl
}:

python3Packages.buildPythonPackage rec {

  pname = "bat";
  version = "master";

  src = fetchurl {
   # url = "https://github.com/SuperCowPowers/${pname}/archive/v${version}.tar.gz";
    url = "https://github.com/SuperCowPowers/${pname}/archive/${version}.tar.gz";
    sha256 = "0qp1xa6ksxwavmk0f2kfcj5sldrndwmlisx42mnrq3pn4hcf2qlf";
  };  
  # src = fetchPypi {
  #   inherit pname version;
  #   sha256 = "13i7mqg14zp63d52lckslvzgxi75div7864rd1m56dqyc4kwxq7d";
  # };
  # src = fetchFromGitHub {
  #   inherit pname
  #   owner = "r9y9";
  #   rev = "$version";
  #   sha256 = "1yjhvakz0ai65i7n4ah5kakfgpp1inz9fghdvchhhl1a1s2scqfp";
  # };
  

  propagatedBuildInputs = with python3Packages; [ pandas
                                                   scikitlearn
                                                   pyarrow
                                                   requests
                                                   watchdog
                                                   numpy
                                                 ];
  doCheck = false;
  
  meta = with stdenv.lib; {
    description = "Bro Analysis Tools (BAT): Processing and analysis of Bro network data with Pandas, scikit-learn, and Spark";
    homepage = "https://github.com/SuperCowPowers/bat";
    license = licenses.asl20;
    maintainers = with maintainers; [ gtrunsec ];
  };

}
