{ config, lib, pkgs, ... }:

{
  home.file.".myscript/agenda-html".source =pkgs.fetchFromGitHub {
    owner = "dantecatalfamo";
    repo = "agenda-html";
    rev = "6dd1cbcd5c9743ec176e2529102ad6825d113419";
    sha256 = "1ca5017wbzvbmpm68qrvclgphzdwhdicaqdwcc3hj5a0w5gxrhjg";
  };
  ##https://github.com/matthewbauer/nix-bundle/commits/master
  home.file.".myscript/nix-bundle".source =pkgs.fetchFromGitHub {
    owner = "matthewbauer";
    repo = "nix-bundle";
    rev = "4300437ede1f10c14cde157d9cce407bd46f5902";
    sha256 = "1axy552dx9x478d2499ghy5rd2rm826f55mnz7zvscykcnk6fk0f";
  };

  home.file.".myscript/eaf".source = pkgs.fetchFromGitHub {
    owner = "manateelazycat";
    repo = "emacs-application-framework";
    rev = "86c6c55f711a3ae72ab4f9f94111b992c3a2ac1b";
    sha256 = "sha256-FLTLxFDpnAfnJd9P4iqmgO+J9DALzX8Xe3T5DomVjXo=";
  };


  home.file.".myscript/snails".source =pkgs.fetchFromGitHub {
    owner = "manateelazycat";
    repo = "snails";
    rev = "28a5b500e43b54de61db13a332ca259e5ec5be71";
    sha256 = "sha256-sREyfOgDGP4dXI6+HO8bq6JP+lvdZp2cppX5Ris5dNY=";
  };

  home.file.".myscript/org-super-links".source = pkgs.fetchFromGitHub {
    owner = "toshism";
    repo = "org-super-links";
    rev = "94f59485e3063f0162b9ab2adddd0b34711d18ef";
    sha256 = "1i9dnkdhfzvhz55n8ghdnzvaxcpkm0yjrkl4acvq1a6jyjb87q48";
  };

}
