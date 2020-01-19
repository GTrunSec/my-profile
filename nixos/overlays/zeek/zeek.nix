  { config, lib, pkgs, ... }:
  with lib;
  let
    zeekUser = "zeek";
    stateDir = "/var/lib/zeek";
    #runDir = "/run/clamav";
    zeekGroup = zeekUser;
    cfg = config.services.zeek;
    pkg = pkgs.zeek;
  in
    {

      preStart = ''
        mkdir -m 0755 -p ${stateDir}
        chown ${zeekUser}:${zeekGroup} ${stateDir}
      '';
    }
