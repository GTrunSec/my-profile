{ config, pkgs, ... }:
{
  deployment.keys = {
     # Database key for nextcloud
     nextcloud-dbpass = {
       text        = "vaetohH{u9Veegh3caechish";
       # Password, generated using pwgen -yB 24
       user        = "gtrun";
       # User to own the key file
       group       = "wheel";
       # Group to own the key file
       permissions = "0640";
       # Key file permissions
     };  };
}
