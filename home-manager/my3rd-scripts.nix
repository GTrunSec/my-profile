{ config, lib, pkgs, ... }:

{
  ##https://github.com/matthewbauer/nix-bundle/commits/master
  home.file.".myscript/nix-bundle".source =pkgs.fetchFromGitHub {
    owner = "matthewbauer";
    repo = "nix-bundle";
    rev = "4300437ede1f10c14cde157d9cce407bd46f5902";
    sha256 = "1axy552dx9x478d2499ghy5rd2rm826f55mnz7zvscykcnk6fk0f";
  };

  home.file.".myscript/eaf".source =pkgs.fetchFromGitHub {
    owner = "manateelazycat";
    repo = "emacs-application-framework";
    rev = "320840214bcb3cd2f5a0729adbe09a0ff56c8148";
    sha256 = "0f4wra2w78nlbfgnwlnpmn2i73lrv4kqcsnfs86asmvf3g26d5jy";
  };


  home.file.".myscript/snails".source =pkgs.fetchFromGitHub {
    owner = "manateelazycat";
    repo = "snails";
    rev = "7e83f3822c00ee496cce42cf69331436cb3b1379";
    sha256 = "1448d333vny2gq4jaldl9zy62jy81ih5166l0aak3p49vv8g38bz";
  };

}
