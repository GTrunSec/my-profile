self: super:

{
  liberime = super.stdenv.mkDerivation rec {
    name = "liberime";
    version = "0.1";
    src = super.fetchgit {
    url    = "https://github.com/GTrunSec/liberime.git";
    rev    = "5784eb1fcfb142a5e1320de2b43a8828d927b70a";
    sha256 = "07qma92n2y07syb9qf2ifma24s2dy4b1w2wsmfcq9342j2c4j8kq";
		    };

    
    nativeBuildInputs = [self.cmake];
    buildInputs = with self; [ gnumake librime];
	  };


}
