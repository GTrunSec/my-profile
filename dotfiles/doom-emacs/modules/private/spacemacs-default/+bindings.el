;;; private/spacemacs-default/+bindings.el -*- lexical-binding: t; -*-


(map!
 :after dired-mode
 :map dired-mode-map
 :g  "j" #'vinegar/move-up
 :g "k" #'vinegar/move-down
 :g "-" #'vinegar/up-directory
 )
