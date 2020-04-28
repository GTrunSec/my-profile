{ stdenv
, python3Packages
, fetchurl
}:

python3Packages.buildPythonPackage rec {

  pname = "editdistance";
  version = "v0.5.3";

  src = fetchurl {
    url = "https://github.com/aflc/editdistance/archive/${version}.tar.gz";
    sha256 = "10kf3lq1m47i1f91m2dbd35wr6lwr5gi4nsdr6ibh43250r7rp68";
  };  

  propagatedBuildInputs = with python3Packages; [
                                                   twine
                                                 ];
  doCheck = false;
  
  meta = with stdenv.lib; {
    description = "Fast implementation of the edit distance(Levenshtein distance)";
    homepage = "https://github.com/aflc/editdistance";
    license = licenses.asl20;
    maintainers = with maintainers; [ gtrunsec ];
  };

}
