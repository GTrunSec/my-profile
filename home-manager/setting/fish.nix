{ config, pkgs, lib, ... }:
with lib;
{

  #fish
  programs.direnv.enable = true;
  programs.fish = let
    plugins = [
      "edc/bass"
      "tuvistavie/fish-fastdir"
      "oh-my-fish/theme-bobthefish"
      "oh-my-fish/plugin-bang-bang"
      "oh-my-fish/plugin-direnv"
      "jethrokuan/fzf"
      "rominf/omf-plugin-fzf-autojump"
      "rominf/omf-plugin-autojump"
    ];
    in {
    enable = true;
    shellAliases = with pkgs; {
      l     = "exa -lah";
      f     = "rg --files";
      E     = "env SUDO_EDITOR=\"emacsclient\" sudo -e";
      em    = "emacs";
      cp    = "cp -i";
      mv    = "mv -i";
      ag0   = "rg --max-depth=1";
      pcat  = "${python3Packages.pygments}/bin/pygmentize";
      so    = "pactl set-default-sink (pacmd list-sinks | awk \\\'/name:.*usb/{if (a != \"\") print a;} {a=$NF}\\\')";
      si    = "pactl set-default-sink (pacmd list-sinks | awk \\\'/name:.*pci/{if (a != \"\") print a;} {a=$NF}\\\')";
    };
    
     interactiveShellInit = ''
      if not functions -q fundle; eval (curl -sfL https://git.io/fundle-install); end
      ${concatMapStringsSep "\n" (p: "fundle plugin '${p}'") plugins}
      fundle init
    #infocmp | ssh $remote "cat > $TERM.ti ; tic -o ~/.terminfo $TERM.ti"
    source ${pkgs.autojump}/share/autojump/autojump.fish
    set -x -U GOPATH $HOME/go 
    set -x -U GOBIN $GOPATH/bin
    set -g -x PATH $PATH $GOBIN
    set -g theme_color_scheme gruvbox
    source ~/.local/share/icons-in-terminal/icons.fish
    kitty + complete setup fish | source
    alias ...='cd ../..'
    alias ....='cd ../../..'
    alias .....='cd ../../../..'
    abbr -a g git
    abbr -a gr "git reset --hard"
    abbr -a gl "git pull --rebase"   

    if status is-interactive
    and not set -q TMUX
    exec tmux
    end 
    '';
  };
  
  home.activation.linkOMF = config.lib.dag.entryAfter [ "writeBoundary" ] ''
    ln -sfT "${config.home.homeDirectory}/.config/nixpkgs/dotfiles/omf" ~/.config/omf
  '';
  home.file.".config/fish/functions/hs.fish".source = ../../dotfiles/fish/functions/hs.fish;
  home.file.".config/fish/functions/clean-nix-store.fish".source = ../../dotfiles/fish/functions/clean-nix-store.fish;
}
