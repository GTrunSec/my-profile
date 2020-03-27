{ config, lib, pkgs, ... }:

{
  home.file.".myscript/wakatime".source =pkgs.fetchFromGitHub {
    owner = "wakatime";
    repo = "wakatime";
    rev = "2e636d389bf5da4e998e05d5285a96ce2c181e3d";
    sha256 = "1i1hlyrhcn4jbv5nmljz1dbmljqaiwjx85f3r1mih2njlc9yymj4";
  };

  home.file.".myscript/fish-wakatime/shell.sh".text =  ''
   set -l project

   if echo (pwd) | grep -qEi "^/Users/$USER/Sites/"
       set  project (echo (pwd) | sed "s#^/Users/$USER/Sites/\\([^/]*\\).*#\\1#")
   else
       set  project "Terminal"
   end

   wakatime --write --plugin "fish-wakatime/0.0.1" --entity-type app --project "$project" --entity (echo $history[1] | cut -d ' ' -f1) 2>&1 > /dev/null&
   ''
}
