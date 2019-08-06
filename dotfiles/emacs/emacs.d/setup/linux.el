(use-package nix-mode
  :straight t
  :config
  (add-to-list 'auto-mode-alist '("\\.nix\\'" . nix-mode))

)
(use-package company-nixos-options
  :straight t
  :after nix-mode
  :config
(add-to-list 'company-backends 'company-nixos-options))

(set-face-attribute
 'default nil
 :font (font-spec :name "-PfEd-Fantasque Sans Mono-bold-italic-normal-*-*-*-*-*-m-0-iso10646-1"
                  :weight 'normal
                  :slant 'normal
                  :size 28))
(dolist (charset '(kana han symbol cjk-misc bopomofo))
  (set-fontset-font
   (frame-parameter nil 'font)
   charset
   (font-spec :name "-ADBO-Source Han Serif CN-semibold-normal-normal-*-*-*-*-*-*-0-iso10646-1"
              :weight 'normal
              :slant 'normal
              :size 28.5)))

(provide 'linux)
