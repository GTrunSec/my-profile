{ config, pkgs, lib, ... }:
let
  #https://github.com/rummik/nixos-config/blob/master/config/home-manager/tmux.nix
  inherit (pkgs) tmuxPlugins tmux;
  inherit (lib) optionalString maybeEnv;
  inherit (pkgs.stdenv) isLinux mkDerivation;
    resurrect-patched = (tmuxPlugins.resurrect.overrideAttrs (oldAttrs: rec {
    src = pkgs.fetchFromGitHub {
      owner = "tmux-plugins";
      repo = "tmux-resurrect";
      rev = "e3f05dd34f396a6f81bd9aa02f168e8bbd99e6b2";
      sha256 = "0w7gn6pjcqqhwlv7qa6kkhb011wcrmzv0msh9z7w2y931hla4ppz";
    };

    # patches = [
    #   ../tmux/resurrect-basename-match-strategy.patch
    #   ../tmux/resurrect-cmdline-save-strategy.patch
    # ];
  }));
in
{
  programs.tmux = {
  enable = true;
  clock24 = true;
  keyMode = "vi";
  extraConfig = /* tmux */ ''
   set-option -g default-shell /run/current-system/sw/bin/fish
   bind r source-file ~/.tmux.conf \; display-message "Config reloaded..."
   set -gu prefix2
   unbind C-a
   set -g prefix C-b
   bind C-b send-prefix
   setw -g mouse 
  '';

  plugins = with tmuxPlugins; [
    {
      plugin = resurrect-patched;
      extraConfig = /* tmux */ ''
          set -g @resurrect-capture-pane-contents "on"
          set -g @resurrect-processes "mosh-client man '~yarn watch'"
          ${optionalString isLinux /* tmux */ ''
          set -g @resurrect-save-command-strategy "cmdline"
          ''}
          set -g @resurrect-process-match-strategy "basename"
          set -g @resurrect-strategy-nvim "session"
        '';
    }
  ]; 
 };
}
