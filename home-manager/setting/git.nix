{pkgs, ...}:
{
  programs.git = {
    enable = true;
    userName = "gtrunsec";
    userEmail = "gtrun@hardenedlinux.org";
#    signing.key = "20C828B69E5458A0";
#    signing.signByDefault = true;
    ignores = [ ".projectile" ".indium.json" ".ccls-cache"
                ".Rhistory" ".notdeft*" ".auctex-auto" "__pycache__"
                "vast.db" "eaf"
                ".ipynb_checkpoints"
              ];
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
      core = {
        pager = [ ''
        delta --plus-color="#012800" --minus-color="#340001"
              ''
                ];
      };

      interactive = {

        diffFilter = "delta --color-only";

      };
    };
  };
}
