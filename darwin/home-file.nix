{ config, lib, pkgs, ... }:

{

  environment.etc = {

  "wakatime.cfg".text = ''
   [settings]
    debug=true
    verbose = true
    offline = true
    api_key = dff3f4c8-2b39-4514-b9c7-2f3a14c928c9
    exclude = ^COMMIT_EDITMSG$
      ^TAG_EDITMSG$
      ^/var/(?!www/).*
      ^/etc/
      ^__pycache__
      ^/zeek
      ^/.notdeft-db/
    include = .*
    include_only_with_project_file = false
    [projectmap]
    ^~/project/hardenedlinux-zeek-script/NSM-data-analysis(\d+)/ = project{0}
    ^~/.config/nixpkgs(\d+)/ = project{1}
    ^~/Documents/org-notes(\d+)/ = project{2}
    [git]
    disable_submodules = false
    '';
  };
}
