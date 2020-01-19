{ config, lib, pkgs, ... }:
{
 services.nextcloud = {
    enable = true;
    hostName = "cloud.gtrun.com";
    home = "/var/www/nextcloud";
    nginx.enable = true;
    config = {
      dbtype = "pgsql";
      dbuser = "nextcloud";
      dbhost = "/run/postgresql"; # nextcloud will add /.s.PGSQL.5432 by itself
      dbname = "nextcloud";
      adminpassFile = "/etc/nixos/secrets/netcloud_adminpass";
      adminuser = "root";
    };
  };

  # services.postgresql = {
  #   enable = true;
  #   ensureDatabases = [ "nextcloud" ];
  #   ensureUsers = [
  #    { name = "nextcloud";
  #      ensurePermissions."DATABASE nextcloud" = "ALL PRIVILEGES";
  #    }
  #   ];
  # };

  # ensure that postgres is running *before* running the setup
  systemd.services."nextcloud-setup" = {
    requires = ["postgresql.service"];
    after = ["postgresql.service"];
  };
}
