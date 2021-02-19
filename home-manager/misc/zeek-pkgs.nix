{ config, lib, pkgs, ... }:
let
  hardenedlinux-zeek-script = pkgs.fetchgit (builtins.fromJSON (builtins.readFile ./zeek-json.json)).hardenedlinux-zeek-script;
  spl-spt = pkgs.fetchFromGitHub (builtins.fromJSON (builtins.readFile ./zeek-json.json)).spl-spt;
  IRC-Zeek-package = pkgs.fetchFromGitHub (builtins.fromJSON (builtins.readFile ./zeek-json.json)).IRC-Zeek-package;
  IRC-Behavioral-Analysis = pkgs.fetchFromGitHub (builtins.fromJSON (builtins.readFile ./zeek-json.json)).IRC-Behavioral-Analysis;
in
{
  home.file = {
    ".zeek-script/__load__.zeek".text = ''
      @load ${hardenedlinux-zeek-script}/scripts
      @load ${spl-spt}/scripts
      ##@load ${IRC-Zeek-package}
      @load ${IRC-Behavioral-Analysis}/zeek/irc_records.zeek
    '';
  };
}
