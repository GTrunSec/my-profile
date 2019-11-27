{ local ? true }:

with import <nixpkgs> {};

let
  lib = import <nixpkgs/lib>;
in

if local then
  if lib.pathExists ./remacs then ./remacs else abort "local remacs source not found"
else fetchFromGitHub {
  owner = "remacs";
  repo = "remacs";
  rev = "7b9cd90c30530dfcaec515e0c10f51af00408310";
  sha256 = "1hxr1094yabmc2yh77pyjfc6rljd9yprg1lbz1sss60ib5qavy3w";
  # date = 2019-06-13T13:01:58-07:00;
}
