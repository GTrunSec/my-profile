{ pkgs, ... }:
{
  xsession.pointerCursor = {
    package = pkgs.gnome3.defaultIconTheme;
    name = "Adwaita";
    size = 128;
  };

}
