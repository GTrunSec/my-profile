{ pkgs ? import <nixpkgs> {} }:

pkgs.vscode-with-extensions.override {
  # When the extension is already available in the default extensions set.
  vscodeExtensions = with pkgs.vscode-extensions; [
    bbenoist.Nix
  ]
    # Concise version from the vscode market place when not available in the default set.
  ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
    # https://github.com/darkoperator/vscode-sysmon
    # Lang-C
    {
      publisher = "ccls-project";
      name = "ccls";
      version = "0.1.28";
      sha256 = "11zn2pbj4y1j2cnn0yhf2dvhkxy9am8d1ja92grh3h86wvz0mw8k";
    }
    
    # Lang-R
    {
      publisher = "Ikuyadeu";
      name = "r";
      version = "1.1.1";
      sha256 = "1rhwq830jyyxqic5a4mb8kyd29lzfjcz5ap51kb4s0s5y3v6l3m8";
    }
    # dotnet-runtime
    # {
    #   publisher = "Mikhail-Arkhipov";
    #   name = "r";
    #   version = "0.0.6";
    #   sha256 = "18a5w0nwicx84y5l14qbbvfd5yh9zi2dcbvclhc51kx3wgkmy29l";
    # }

    {
      publisher = "REditorSupport";
      name = "r-lsp";
      version = "0.1.0";
      sha256 = "0kqh53jx314bsv3x48vyf29blkicr2jdwgz7vj5vklf9zxd3n1pa";
    }


    # Lang-Go
    {
      publisher = "ms-vscode";
      name = "Go";
      version = "0.11.4";
      sha256 = "0h0z4kgm0d2milbmna2j0saic3yq5p07l18dflyqwvm9zvjx9x5f";
    }

    {
      publisher = "premparihar";
      name = "gotestexplorer";
      version = "0.1.10";
      sha256 = "1z4n5hhm5qx97an6s2c7m7vlx5rqvzwqq1ywwz93zdnmlc3v0nks";
    }

    {
      publisher = "ms-python";
      name = "python";
      version = "2019.10.41019";
      sha256 = "0szikd76vy8mgv8zc0m90rx1jrnwwphx5bb8928drln65xwbzs1q";
    }
    
    {
      name = "matchit";
      publisher = "redguardtoo";
      version = "1.0.1";
      sha256 = "1jjpzr48gpcxx1ic0k1mmvrghpx5drgcl6gh8rwcn57lshzrs4a4";
    }

    {
      name = "bro";
      publisher = "aeppert";
      version = "0.6.0";
      sha256 = "01a2g6n9jq2l9fjcg4pnff94cyhgll16hkn7wxsgkas65cc140pv";

    }


    {
      name = "vscode-emacs-friendly";
      publisher = "lfs";
      version = "0.9.0";
      sha256 = "1j4cy77m1077wdl2vvpmzi98y3jkycvf8z84pscs3lkkk1mvcsv1";

    }

    {
      name = "readable-indent";
      publisher = "cnojima";
      version = "1.2.1";
      sha256 = "08mn7rmcy27vbnphjw7ngi2k4g9rz5waip1kfp8sw7pkvh0gzg1m";

    }

    {
      name = "indent-rainbow";
      publisher = "oderwat";
      version = "7.4.0";
      sha256 = "1xnsdwrcx24vlbpd2igjaqlk3ck5d6jzcfmxaisrgk7sac1aa81p";

    }
    
    {
      name = "rainbow-brackets";
      publisher = "2gua";
      version = "0.0.6";
      sha256 = "1m5c7jjxphawh7dmbzmrwf60dz4swn8c31svbzb5nhaazqbnyl2d";

    }
    
    {
      publisher = "formulahendry";
      name = "code-runner";
      version = "0.9.14";
      sha256 = "15y5ngcncbhssikx90sx9v3z108w2q3bgvk3j7i7w1v04p5i6wsw";

    }

    {
      publisher = "TabNine";
      name = "tabnine-vscode";
      version = "2.1.11";
      sha256 = "0nr8wfxlbb613f29m34jnv1ldfhw6sf5s1pbarmxa7zkkyp46jam";

    }

    
   ];
}
