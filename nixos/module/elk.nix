{ config, lib, pkgs, ... }:

{
  services.zookeeper = {
    enable = true;
  };
  services.apache-kafka = {
    enable = true;
  };
}
