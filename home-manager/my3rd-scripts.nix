{ config, lib, pkgs, ... }:

{
  home.file.".myscript/agenda-html".source = pkgs.fetchFromGitHub {
    owner = "dantecatalfamo";
    repo = "agenda-html";
    rev = "6dd1cbcd5c9743ec176e2529102ad6825d113419";
    sha256 = "1ca5017wbzvbmpm68qrvclgphzdwhdicaqdwcc3hj5a0w5gxrhjg";
  };

  home.file.".myscript/plantuml".source = pkgs.fetchurl {
    url = "mirror://sourceforge/project/plantuml/1.2020.16/plantuml.1.2020.16.jar";
    sha256 = "0k9dligb0b2kc8rl9k5wp9sh8z1kb8g97v5pfiiwa321lp8y6wpp";
  };
  ##https://github.com/matthewbauer/nix-bundle/commits/master
  home.file.".myscript/nix-bundle".source = pkgs.fetchFromGitHub {
    owner = "matthewbauer";
    repo = "nix-bundle";
    rev = "4300437ede1f10c14cde157d9cce407bd46f5902";
    sha256 = "1axy552dx9x478d2499ghy5rd2rm826f55mnz7zvscykcnk6fk0f";
  };
}
