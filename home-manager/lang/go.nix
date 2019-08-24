{ pkgs, ... }:

{
  home.packages = with pkgs;[
    go
    # Guru and other tools
    gotools
    # Dependencies
    dep
  ];

}
