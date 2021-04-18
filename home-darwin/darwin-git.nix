{ pkgs, lib, ... }:
{
  programs.git = {
    enable = true;
    userName = "GTrunSec";
    userEmail = "gtrunsec@hardenedlinux.org";
    # gpg --list-secret-keys --keyid-format LONG
    signing.key = "B1A1304430618C3C";
    ignores = [
      ".projectile"
      ".indium.json"
      ".ccls-cache"
      ".Rhistory"
      ".notdeft*"
      "eaf"
      ".auctex-auto"
      "vast.db"
      ".DS_Store"
      "result"
      ".ipynb_checkpoints"
      "__pycache__"
      "*.org.organice-bak"
      ".direnv"
      ".direnv.d"
      ".secrets"
      ".cargo"
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
        pager = [
          ''
            delta --plus-color="#012800" --minus-color="#340001"
          ''
        ];
      };
      credential = {
        helper = "store";
      };

      interactive = {
        diffFilter = "delta --color-only";
      };
    };
  };
  programs.git.signing.signByDefault = true;
}
