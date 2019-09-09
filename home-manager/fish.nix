{ config, pkgs, ... }:

{


  #fish
  programs.direnv.enable = true;
  programs.fish = {
    enable = true;
    shellAliases = with pkgs; {
      l = "exa -lah";
      f = "rg --files";
      E = "env SUDO_EDITOR=\"emacsclient\" sudo -e";
      pcat = "${python3Packages.pygments}/bin/pygmentize";
      so = "pactl set-default-sink (pacmd list-sinks | awk \\\'/name:.*usb/{if (a != \"\") print a;} {a=$NF}\\\')";
      si = "pactl set-default-sink (pacmd list-sinks | awk \\\'/name:.*pci/{if (a != \"\") print a;} {a=$NF}\\\')";
    };
    interactiveShellInit = ''
    #infocmp | ssh $remote "cat > $TERM.ti ; tic -o ~/.terminfo $TERM.ti"
    set -x -U GOPATH $HOME/go 
    set -x -U GOBIN $GOPATH/go/bin
    set -g -x PATH $PATH $GOBIN ~/.config/nixpkgs/nixos/overlays/python/result/bin/python
    source ~/.local/share/icons-in-terminal/icons.fish
    kitty + complete setup fish | source
    '';
  };

  
  home.file.".config/fish/functions/hs.fish".source = ../dotfiles/fish/functions/hs.fish;
  home.file.".config/fish/functions/clean-nix-store.fish".source = ../dotfiles/fish/functions/clean-nix-store.fish;
}
