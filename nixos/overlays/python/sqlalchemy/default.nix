{ lib
, python35Packages
, fetchurl
, isPy3k
, mock
, pysqlite
, pytest
}:

python35Packages.buildPythonPackage rec {
  pname = "SQLAlchemy";
  version = "1.3.8";

  src = fetchurl {
    inherit pname version;
    url = "https://github.com/sqlalchemy/${pname}/archive/v${version}.tar.gz";
    sha256 = "2f8ff566a4d3a92246d367f2e9cd6ed3edeef670dcd6dda6dfdc9efed88bcd80";
  };

  checkInputs = [
    pytest
    mock
  ] ++ lib.optional (!isPy3k) pysqlite;

  postInstall = ''
    sed -e 's:--max-worker-restart=5::g' -i setup.cfg
  '';

  checkPhase = ''
    pytest test
  '';

  meta = with lib; {
    homepage = http://www.sqlalchemy.org/;
    description = "A Python SQL toolkit and Object Relational Mapper";
    license = licenses.mit;
  };
}
