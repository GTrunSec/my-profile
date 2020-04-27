{ stdenv
, python3Packages
, python3
}:
let
  jupyter_server = python3Packages.buildPythonPackage rec {
    pname = "jupyter_server";
    version = "0.1.1";
    src = python3Packages.fetchPypi {
      inherit pname version;
      sha256 = "121q60ilx0i8fh0ixzj835cv1naaakivckwmvw9mxnmqrb6fdf1y";
    };
    doCheck = false;

    propagatedBuildInputs = with python3Packages; [ nbformat
                                                    tornado
                                                    ipykernel
                                                    jinja2
                                                    nbconvert
                                                    (python3Packages.buildPythonPackage rec {
                                                      pname = "Send2Trash";
                                                      version = "1.5.0";
                                                      src = python3Packages.fetchPypi {
                                                        inherit pname version;
                                                        sha256 = "1ci8vcwjmjlp11ljj1ckrfmml9fkq1mclx2gr53y4zvhgp01q030";
                                                      };
                                                      doCheck = false;
                                                      propagatedBuildInputs = with python3Packages; [  ];
                                                    })
                                                    pygments
                                                    (python3Packages.buildPythonPackage rec {
                                                      pname = "jupyterlab_pygments";
                                                      version = "0.1.0";
                                                      src = python3Packages.fetchPypi {
                                                        inherit pname version;
                                                        sha256 = "1id54fff3hhg4ya1qp7k9hnyy15ak5hrziv40wci9c0ipmsxmpii";
                                                      };
                                                      doCheck = false;
                                                      propagatedBuildInputs = with python3Packages; [ pygments ];
                                                    })
                                                    terminado
                                                    prometheus_client
                                                    jupyter_client
                                                    # (jupyter_client.overrideDerivation(oldAttrs: {
                                                    #    pname = "jupyter_client";
                                                    #    version = "6.1.1";
                                                    #   src = fetchPypi {
                                                    #     pname = "jupyter_client";
                                                    #     version = "6.1.1" ;
                                                    #     sha256 = "1i41bbzyfimbg1z7a5xd2nz4n5i1q29i8c8a2n6q5vp11xwbgz3f";
                                                    #   };
                                                    # }))
                                                  ];
  };

in
with python3.pkgs;
python3Packages.buildPythonPackage rec {
pname = "voila";
    version = "0.1.21";
    src = fetchPypi {
      inherit pname version;
      sha256 = "1asr4inrqaisvzgpw5im2fx7xxzdyqi3y0kfzq2n7y977hxwdr3f";
    };
    doCheck = false;
    propagatedBuildInputs = with python3Packages; [ async_generator
                                                    jupyter_server
                                                  ];
}
