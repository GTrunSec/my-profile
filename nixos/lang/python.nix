{ config, pkgs, ... }:
{
   #inherit (pkgs)  libyaml libiconv;
  environment.systemPackages = with pkgs; [
    (python37.withPackages (ps: with ps; [ numpy toolz ]))
    (python35.withPackages(ps: with ps; [ numpy toolz ]))
  ];
}
