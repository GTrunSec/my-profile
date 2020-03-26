{ config, lib, pkgs, ... }:

{
  programs.tmux.enable = true;
  programs.tmux.enableVim = true;
  programs.tmux.tmuxConfig = ''
   set -g default-shell /run/current-system/sw/bin/fish
   set -g default-command /run/current-system/sw/bin/fish

   bind r source-file ~/.tmux.conf \; display-message "Config reloaded..."
   set -gu prefix2
   unbind C-a
   set -g prefix C-b
   bind C-b send-prefix
   set -g mouse on
   set -g status-style fg=colour136,bg=colour235
   set -g default-terminal "xterm-256color"
   # default window title colors
   set-window-option -g window-status-style fg=colour244,bg=default #base0 and default
   #set-window-option -g window-status-style dim

   # active window title colors
   set-window-option -g window-status-current-style fg=colour166,bg=default #orange and default
   #set-window-option -g window-status-current-style bright

   #  pane border
   set -g pane-border-style fg=colour235 #base02
   set -g pane-active-border-style fg=colour240 #base01

   # message text
   set-option -g message-style fg=colour166,bg=colour235 #orange and base02

   # pane number display
   set-option -g display-panes-active-colour colour33 #blue
   set-option -g display-panes-colour colour166 #orange
   # clock
   set-window-option -g clock-mode-colour colour64 #green
   # bell
   set-window-option -g window-status-bell-style fg=colour235,bg=colour160 #base02, red
   # https://www.rushiagr.com/blog/2016/06/16/everything-you-need-to-know-about-tmux-copy-pasting-ubuntu/
   bind P paste-buffer
   bind-key -T copy-mode-vi v send-keys -X begin-selection
   bind-key -T copy-mode-vi y send-keys -X copy-selection
   bind-key -T copy-mode-vi r send-keys -X rectangle-toggle
  '';
  programs.tmux.enableSensible = true;
  programs.tmux.enableMouse = true;
  programs.tmux.enableFzf = true;
}
