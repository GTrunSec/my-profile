{pkgs, ...}:
{
  programs.git = {
    enable = true;
    userName = "GTrunSec";
    userEmail = "gtrun@hardenedlinux.org";
    signing.key = "761C8EBEA940960E";
    #signing.signByDefault = true;
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
