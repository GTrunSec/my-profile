with import <nixpkgs> {};
let 
  my-jupyter = jupyter.override {
    python3 = python3.withPackages (ps: with ps; [ pandas scipy matplotlib ]);
  };
in
  mkShell rec {
    name = "gtrun-jupyter";
    buildInputs = [ my-jupyter ];
    shellHook = ''
      jupyter notebook
    '';
  }
