{ stdenv
, python3Packages
, fetchurl
}:

python3Packages.buildPythonPackage rec {

  pname = "ipynb-py-convert";
  version = "master";

  src = fetchurl {
    url = "https://github.com/kiwi0fruit/ipynb-py-convert/archive/${version}.tar.gz";
    sha256 = "0w47xacnpbjy8pi41475a4f5dmvdyr6ni1m7sd5w91ipbapahcpa";
  };  

  propagatedBuildInputs = with python3Packages; [];
  doCheck = false;
  
  meta = with stdenv.lib; {
    description = "Convert .py files runnable in VSCode or Atom/Hydrogen to Jupyter .ipynb notebooks and vice versa";
    homepage = "https://github.com/kiwi0fruit/ipynb-py-convert";
    license = licenses.asl20;
    maintainers = with maintainers; [ gtrunsec ];
  };

}
