(use-package snails
  :load-path "./setup/snails"
  :config
  (define-key snails-mode-map [remap next-line] #'snails-select-next-item)
  (add-hook 'snails-mode-hook #'xah-fly-insert-mode-activate)
  )

(setq lsp-python-ms-executable
      "~/src/python-language-server/output/bin/Release/osx-x64/publish/Microsoft.Python.LanguageServer")

(use-package tree-sitter
:load-path "~/project/emacs/tree-sitter.el/tree-sitter-0.0.3"
:load-path "~/project/emacs/tree-sitter.el/langs/python"
:load-path "~/project/emacs/tree-sitter.el/langs/go"
:config
(require 'tree-sitter)
(require 'tree-sitter-live)
(require 'tree-sitter-live-preview)
(require 'tree-sitter-lang-python)
(require 'tree-sitter-lang-go)


(setq tree-sitter-live-auto-alist
      '((go-mode . tree-sitter-lang-go)
        (python-mode . tree-sitter-lang-python)))
(global-tree-sitter-live-mode t)

)

;; FIXME macos can't load org correctly by onece

(add-hook 'after-init-hook #'org-reload)
(add-hook 'after-init-hook #'org-super-agenda-mode)

(use-package cnfonts
  :straight t
  :init
 (defun cnfonts--set-all-the-icons-fonts (&optional _)
    "Show icons in all-the-icons."
    (when (featurep 'all-the-icons)
      (dolist (charset '(kana han cjk-misc bopomofo gb18030))
        (set-fontset-font "fontset-default" charset "all-the-icons" nil 'append)
        (set-fontset-font "fontset-default" charset "github-octicons" nil 'append)
        (set-fontset-font "fontset-default" charset "FontAwesome" nil 'append)
        (set-fontset-font "fontset-default" charset "Material Icons" nil 'append)
        (set-fontset-font "fontset-default" charset "file-icons" nil 'append)
        (set-fontset-font "fontset-default" charset "Weather Icons" nil 'append))))
  :hook ((after-init . cnfonts-enable)
         (cnfonts-set-font-finish . cnfonts--set-all-the-icons-fonts))
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
    :font (font-spec :name "-*-Fantasque Sans Mono-normal-normal-normal-*-*-*-*-*-m-0-iso10646-1"
                     :weight 'normal
                     :slant 'normal
                     :size 24.0))
   (dolist (charset '(kana han symbol cjk-misc bopomofo))
     (set-fontset-font
      (frame-parameter nil 'font)
      charset
      (font-spec :name "-*-STFangsong-normal-normal-normal-*-*-*-*-*-p-0-iso10646-1"
                 :weight 'normal
                 :slant 'normal
                 :size 24.5)))

(setq-default cursor-type 'bar)

(blink-cursor-mode -1)
(set-cursor-color "yellow1")

(setq insert-directory-program "/usr/local/bin/gls")
(org-link-set-parameters "skim" :follow #'org-mac-skim-open)
(defun org-mac-skim-open (uri)
  "Visit page of pdf in Skim"
  (let* ((page (when (string-match "::\\(.+\\)\\'" uri)
                 (match-string 1 uri)))
         (document (substring uri 0 (match-beginning 0))))
    (do-applescript
     (concat
      "tell application \"Skim\"\n"
      "activate\n"
      "set theDoc to \"" document "\"\n"
      "set thePage to " page "\n"
      "open theDoc\n"
      "go document 1 to page thePage of document 1\n"
      "end tell"))))


;; librime 
(setq load-path (cons (file-truename "~/.emacs.d/") load-path))

(require 'pyim)
(require 'posframe)
(require 'liberime)

(setq pyim-page-tooltip 'posframe)
(setq pyim-page-length 9)

(liberime-start "/Library/Input Methods/Squirrel.app/Contents/SharedSupport" (file-truename "~/.emacs.d/pyim/rime/"))
(liberime-select-schema "luna_pinyin_simp")
(setq pyim-default-scheme 'rime-quanpin)

(provide 'macos)
