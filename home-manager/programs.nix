{ config, lib, pkgs, ... }:


let  
    vscode = pkgs.vscode-with-extensions.override {
      vscodeExtensions = with pkgs.vscode-extensions; [
        ms-vscode.cpptools
        bbenoist.Nix
        (pkgs.vscode-utils.buildVscodeMarketplaceExtension {
          mktplcRef = {
            name = "tabnine-vscode";
            publisher = "TabNine";
            version = "2.1.11";
            sha256 = "0nr8wfxlbb613f29m34jnv1ldfhw6sf5s1pbarmxa7zkkyp46jam";
          };
        })

        (pkgs.vscode-utils.buildVscodeMarketplaceExtension {
          mktplcRef = {
            name = "matchit";
            publisher = "redguardtoo";
            version = "1.0.1";
            sha256 = "1jjpzr48gpcxx1ic0k1mmvrghpx5drgcl6gh8rwcn57lshzrs4a4";
          };
        })

        (pkgs.vscode-utils.buildVscodeMarketplaceExtension {
          mktplcRef = {
            name = "bro";
            publisher = "aeppert";
            version = "0.6.0";
            sha256 = "01a2g6n9jq2l9fjcg4pnff94cyhgll16hkn7wxsgkas65cc140pv";
          };
        })

        
        (pkgs.vscode-utils.buildVscodeMarketplaceExtension {
          mktplcRef = {
            name = "vscode-emacs-friendly";
            publisher = "lfs";
            version = "0.9.0";
            sha256 = "1j4cy77m1077wdl2vvpmzi98y3jkycvf8z84pscs3lkkk1mvcsv1";
          };
        })

        (pkgs.vscode-utils.buildVscodeMarketplaceExtension {
          mktplcRef = {
            name = "readable-indent";
            publisher = "cnojima";
            version = "1.2.1";
            sha256 = "08mn7rmcy27vbnphjw7ngi2k4g9rz5waip1kfp8sw7pkvh0gzg1m";
          };
        })

        (pkgs.vscode-utils.buildVscodeMarketplaceExtension {
          mktplcRef = {
            name = "python";
            publisher = "ms-python";
            version = "2019.8.30787";
            sha256 = "078gmq57l91ny5panmr82yh46rmyqclqy05sdpvnidllkcfg8kcz";
          };
        })

        (pkgs.vscode-utils.buildVscodeMarketplaceExtension {
          mktplcRef = {
            name = "indent-rainbow";
            publisher = "oderwat";
            version = "7.4.0";
            sha256 = "1xnsdwrcx24vlbpd2igjaqlk3ck5d6jzcfmxaisrgk7sac1aa81p";
          };
        })

      ];
    };
in
{

home.packages = with pkgs; [
  vscode
];
}
