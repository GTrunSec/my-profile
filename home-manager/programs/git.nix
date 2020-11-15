{pkgs, lib, ...}:
{
  config = with lib; mkMerge [
    (mkIf (pkgs.stdenv.isLinux || pkgs.stdenv.isDarwin) {
      programs.git = {
        enable = true;
        userName = "GTrunSec";
        userEmail = "gtrunsec@hardenedlinux.org";
        signing.key = "761C8EBEA940960E";
        ignores = [ ".projectile" ".indium.json" ".ccls-cache"
                    ".Rhistory" ".notdeft*"  "eaf"
                    ".auctex-auto"
                    "vast.db" ".DS_Store" "result"
                    ".ipynb_checkpoints" "__pycache__"
                  ];
        extraConfig = {

          github = {
            user = "gtrunsec";
          };

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
    })
    (mkIf pkgs.stdenv.isLinux {
      programs.git.signing.signByDefault = true;
    })

    (mkIf pkgs.stdenv.isDarwin {
      programs.git.signing.signByDefault = false;
    })
  ];
  
}
