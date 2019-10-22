{ config, lib, pkgs, ... }:
{
  config = {
    services.postgresql = {
      enable = true;
      package = pkgs.postgresql_10;
      authentication = lib.mkForce ''
        # "local" is for Unix domain socket connections only
        local   all             all                                     trust
        local   all             all                                     md5
        # IPv4 local connections:
        host    all             all             127.0.0.1/32            trust
        # IPv6 local connections:
        host    all             all             ::1/128                 trust
        # Allow replication connections from localhost, by a user with the
        # replication privilege.
        local   replication     all                                     trust
        host    replication     all             127.0.0.1/32            trust
        host    replication     all             ::1/128                 trust
      '';
    };
  };
}