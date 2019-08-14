;; (straight-use-package '(snails :type git
 ;;                                :host github
 ;;                                :repo "manateelazycat/snails"))
 ;;  (define-key snails-mode-map [remap next-line] #'snails-select-next-item)
(use-package snails
 :load-path "./setup/snails"
 :config
 (define-key snails-mode-map [remap next-line] #'snails-select-next-item)
 (add-hook 'snails-mode-hook #'xah-fly-insert-mode-activate)
 )

(setq lsp-python-ms-executable
      "~/src/python-language-server/output/bin/Release/linux-x64/publish/Microsoft.Python.LanguageServer")

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

(use-package cnfonts
    :straight t
    :hook ((after-init . cnfonts-enable))
    :config
  (setq cnfonts-use-cache t)
    (setq cnfonts-keep-frame-size nil)
    (add-hook 'window-setup-hook (lambda ()
                                   (setq cnfonts-keep-frame-size t)))
    ;; Set profiles
    (setq cnfonts-directory (concat no-littering-var-directory "cnfonts"))
    (setq cnfonts-profiles '("program1" "program2" "program3" "org-mode" "read-book"))
    (setq cnfonts--profiles-steps '(("program1" . 4)
                                    ("program2" . 5)
                                    ("program3" . 3)
                                    ("org-mode" . 6)
                                    ("read-book" . 8)))
)

(set-face-attribute
 'default nil
 :font (font-spec :name "-PfEd-Fantasque Sans Mono-normal-italic-normal-*-*-*-*-*-m-0-iso10646-1"
                  :weight 'normal
                  :slant 'normal
                  :size 26.0))
(dolist (charset '(kana han symbol cjk-misc bopomofo))
  (set-fontset-font
   (frame-parameter nil 'font)
   charset
   (font-spec :name "-ADBO-Source Han Sans CN-normal-normal-normal-*-*-*-*-*-*-0-iso10646-1"
              :weight 'normal
              :slant 'normal
              :size 31.5)))

(provide 'linux)
