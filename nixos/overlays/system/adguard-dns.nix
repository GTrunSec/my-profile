{ stdenv, fetchFromGitHub, buildGoModule }:

buildGoModule rec {
  name = "dnsproxy-${version}";
  version = "0.19.5";

  src = fetchFromGitHub {
    owner = "AdguardTeam";
    repo = "dnsproxy";
    rev = "v${version}";
    sha256 = "1af109k985m6k0xi2jcsnybby210rs5prp1ydrybxkpk3mrkg1ia";
  };

  modSha256 = "1fgd1x6ph6slmqa3axjs0c3mwwrqsf8z2a6n9nf17az669bvi757";

  meta = with stdenv.lib; {
    homepage = https://github.com/AdguardTeam/dnsproxy;
    license = licenses.gpl3;
    description = "Simple DNS proxy with DoH, DoT, and DNSCrypt support.";
    platforms = platforms.linux;
  };
}
