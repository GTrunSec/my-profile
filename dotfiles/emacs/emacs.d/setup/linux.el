(setq lsp-python-ms-executable
         "~/.nix-profile/bin/mspyls")

;; (setq lsp-python-ms-executable
;;       "$out/opt/mspyls/Microsoft.Python.LanguageServer")

(use-package nix-mode
  :straight t
  :config
  (add-to-list 'auto-mode-alist '("\\.nix\\'" . nix-mode))

)
(use-package company-nixos-options
  :straight t
  :after nix-mode
  :config
  (defun my-nix-mode-setup ()
    (setq-local company-backends
                (append '((company-files company-nixos-options company-tabnine company-yasnippet )))))

)
  (add-hook 'nix-mode-hook 'my-nix-mode-setup)

;;(setq python-shell-interpreter "~/.config/nixpkgs/nixos/overlays/python/result/bin/python")

;; where to store persistant files
(setq bm-repository-file (f-join no-littering-var-directory "bm-linux-data"))

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

;; (set-face-attribute
;;  'default nil
;;  :font (font-spec :name "-PfEd-Fantasque Sans Mono-normal-italic-normal-*-*-*-*-*-m-0-iso10646-1"
;;                   :weight 'normal
;;                   :slant 'normal
;;                   :size 16.0))
;; (dolist (charset '(kana han symbol cjk-misc bopomofo))
;;   (set-fontset-font
;;    (frame-parameter nil 'font)
;;    charset
;;    (font-spec :name "-ADBO-Source Han Sans CN-normal-normal-normal-*-*-*-*-*-*-0-iso10646-1"
;;               :weight 'normal
;;               :slant 'normal
;;               :size 20.5)))

(setq-default cursor-type 'box)
(setq bookmark-default-file
      (concat user-emacs-directory "var/bookmark-linux-default.el"))
;; librime 
;; (setq load-path (cons (file-truename "~/.config/nixpkgs/dotfiles/emacs/emacs.d/") load-path))

;;(require 'pyim)
;;  (require 'posframe)
;;  (require 'liberime)

;; (setq pyim-page-tooltip 'posframe)
;;  (setq pyim-page-length 9)

;; (liberime-start
;; (expand-file-name "~/.emacs.d/pyim/rime/"))
;; (liberime-select-schema "luna_pinyin_simp")
;; (setq pyim-default-scheme 'rime-quanpin)

(blink-cursor-mode -1)
(set-cursor-color "IndianRed3")

(provide 'linux)
