{ stdenv
, python3Packages
, fetchurl
}:

python3Packages.buildPythonPackage rec {

  pname = "orgbabelhelper";
  version = "v1.0.7";

  src = fetchurl {
    url = "https://files.pythonhosted.org/packages/68/96/6ad222e24df1d18a0fb98696959cf2fd8b465ad09c9dedc6b4c70834c3bb/orgbabelhelper-1.0.7.tar.gz";
    sha256 = "9b0c7d32b260f99bfeebb51a6f158004b572468fe9d25c5dfb6f0490372ca29f";
  };  

  propagatedBuildInputs = with python3Packages; [ pandas];
  doCheck = false;
  
  meta = with stdenv.lib; {
    description = "python helper module for Emacs org mode babel";
    homepage = "https://github.com/dfeich/org-babel-examples/tree/master/python";
    license = licenses.asl20;
    maintainers = with maintainers; [ gtrunsec ];
  };

}
