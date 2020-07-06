{ config, pkgs, ... }:

{
  imports = [
    ./clamav.nix
    ./zeek.nix
  ];

  services.zeek = {
    enable = true;
    standalone = true;
    interface = "eno1";
    listenAddress = "localhost";
    package = pkgs.own-zeek.override{ KafkaPlugin = true; PostgresqlPlugin = true; };
    privateScript = ''
    @load /home/gtrun/project/hardenedlinux-zeek-script/scripts/zeek-query.zeek
    '';
  };

}
