self: super: {

  bat = super.python3Packages.buildPythonPackage rec {
    pname = "bat";
    version = "0.3.6";

    src = super.python3Packages.fetchPypi {
      inherit pname version;
      sha256 = "12cf0ygpz9srpfh9gx2f9ba0swa1rzypv3sm4r0hmjyw6b4nm2w0";
    };

    doCheck = false;
    meta = with super.stdenv.lib; {
      description = "Bro Analysis Tools (BAT): Processing and analysis of Bro network data with Pandas, scikit-learn, and Spark";
      homepage = "https://github.com/SuperCowPowers/bat";
      license = licenses.asl20;
      maintainers = with maintainers; [ gtrunsec ];
    };
  };
}
