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
(require 'tree-sitter-lang-python)
(require 'tree-sitter-lang-go)


(setq tree-sitter-live-auto-alist
      '((python-mode . tree-sitter-lang-python)))

(setq tree-sitter-live-auto-alist
      '((go-mode . tree-sitter-lang-go)))
(global-tree-sitter-live-mode t)
)

;; FIXME macos can't load org correctly by onece


(add-hook 'after-init-hook #'org-reload)
(add-hook 'after-init-hook #'org-super-agenda-mode)

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
