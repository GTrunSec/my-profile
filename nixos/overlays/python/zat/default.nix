{ stdenv
, python3Packages
, fetchurl
, gcc8
}:

python3Packages.buildPythonPackage rec {

  pname = "zat";
  version = "v0.3.8";
  src = fetchurl {
   # url = "https://github.com/SuperCowPowers/${pname}/archive/v${version}.tar.gz";
    url = "https://github.com/SuperCowPowers/zat/archive/${version}.tar.gz";
    sha256 = "0a5w7zglayq955rxhc1rbq9vzyi0gwln5abwnwzra13bq86yrdgw";
  };  


  propagatedBuildInputs = with python3Packages; [ pandas
                                                   scikitlearn
                                                   pyarrow
                                                   requests
                                                   watchdog
                                                  numpy
                                                  gcc8
                                                  pyspark
                                                 ];
  doCheck = false;
  
  meta = with stdenv.lib; {
    description = "Bro Analysis Tools (BAT): Processing and analysis of Bro network data with Pandas, scikit-learn, and Spark";
    homepage = "https://github.com/SuperCowPowers/bat";
    license = licenses.asl20;
    maintainers = with maintainers; [ gtrunsec ];
  };

}
