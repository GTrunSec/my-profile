{ pkgs, ... }:
with pkgs;
let
    my-python-packages = python-packages: with python-packages; [
      pandas
      requests
    ];
      python-with-my-packages = python3.withPackages my-python-packages;
in
{
  environment.systemPackages = with pkgs; [
    python-with-my-packages
   ];
}
