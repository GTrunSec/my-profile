{pkgs, ...}:
{
  programs.git = {
    enable = true;
    userName = "gtrunsec";
    userEmail = "gtrun@hardenedlinux.org";
#    signing.key = "20C828B69E5458A0";
#    signing.signByDefault = true;
    ignores = [ ".projectile" ".indium.json" ];
    extraConfig = {
      pull = {
        rebase = true;
      };
      merge = {
        ff = "only";
      };
      rebase = {
        autostash = true;
      };
    };
  };
}
