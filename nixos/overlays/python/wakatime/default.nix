{ stdenv
, python3Packages
, python3
}:

with python3.pkgs;
python3Packages.buildPythonPackage rec {
  pname = "wakatime";
  version = "13.0.7";

    src = fetchPypi {
      inherit pname version;
      sha256 = "07a6d07e1227e3bd45242a2a4861d105bddc6220174a9b739c551bd2d45ce0fd";
  };

    propagatedBuildInputs = with python3Packages; [ nose
                                                    mock
                                                  ];
  doCheck = false;

  meta = with stdenv.lib; {
    homepage = https://github.com/wakatime/wakatime;
    description = "Command line interface used by all WakaTime text editor plugins. ";
    license = licenses.mit;
  };
}
