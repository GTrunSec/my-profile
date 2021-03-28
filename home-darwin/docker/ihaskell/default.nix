# default.nix
let
  pkgs = {
    ihaskell = builtins.fetchTarball {
      url = "https://github.com/gibiansky/IHaskell/tarball/93bfa3a7a434c1dfe6873c2105c43856c282e183";
      sha256 = "1cvqqmpvz7s3d7zclmkm5igx36clrbdiafs47i9rik3rdzw0gr3d";
    };
    nixpkgs = builtins.fetchTarball {
      url = "https://github.com/NixOS/nixpkgs-channels/tarball/9ca57dc9171ca4547abf076a8987ed73c46f2e15";
      sha256 = "18d01cw6s6k9fnac3vq0k6inybqalkz4ak88pw67q4wqzq9rc07l";
    };
  };
  nixpkgs = import pkgs.nixpkgs { };
  NB_USER = "gtrun";
  NB_UID = "1000";
  dockerEtc = nixpkgs.runCommand "docker-etc" { } ''
    mkdir -p $out/etc/pam.d

    echo "root:x:0:0::/root:/bin/sh" > $out/etc/passwd
    echo "${NB_USER}:x:1000:1000::/home/${NB_USER}:" >> $out/etc/passwd
    echo "root:!x:::::::" > $out/etc/shadow
    echo "${NB_USER}:!:::::::" >> $out/etc/shadow

    echo "root:x:0:" > $out/etc/group
    echo "${NB_USER}:x:1000:" >> $out/etc/group
    echo "root:x::" > $out/etc/gshadow
    echo "${NB_USER}:!::" >> $out/etc/gshadow
  '';
  ihaskell = import "${pkgs.ihaskell}/release.nix" {
    inherit nixpkgs;
    compiler = "ghc864";
    packages = self: with self; [ ];
  };
in
nixpkgs.dockerTools.buildLayeredImage {
  name = "ihaskell-nix";
  tag = "latest";
  contents = [
    dockerEtc
    ihaskell
    nixpkgs.bashInteractive
  ];
  config = {
    Cmd = [ "ihaskell-notebook" "--ip" "0.0.0.0" ];
    User = NB_USER;
    WorkingDir = "/home/${NB_USER}";
  };
  extraCommands = ''
    mkdir -m 1777 ./tmp
    mkdir -m 777 -p ./home/${NB_USER}
  '';
  maxLayers = 100;
}
