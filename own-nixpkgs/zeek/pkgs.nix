let
  src = builtins.fetchTarball {
    url    = "https://github.com/GTrunSec/nixpkgs/tarball/6d02fcb2c2fe6e1198dabba2566a859568e4b8d3";
    sha256 = "1q7asvk73w7287d2ghgya2hnvn01szh65n8xczk4x2b169c5rfv0";
  };
in
import src
