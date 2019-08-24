(require 'package)

(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))


(setq package-enable-at-startup nil
      package-check-signature nil
      package-archives '(("GNU ELPA"     . "http://elpa.gnu.org/packages/")
                        ; ("MELPA Stable" . "http://stable.melpa.org/packages/")
                         ("MELPA"        . "http://melpa.org/packages/")
                         ("ORGMODE"      . "http://orgmode.org/elpa/"))
      package-archive-priorities  '(("ORGMODE"      . 15)
                         ;           ("MELPA Stable" . 10)
                                    ("GNU ELPA"     . 5)
                                    ("MELPA"        . 10)))

;;27 version unness
(package-initialize)

(straight-use-package 'use-package)
(setq use-package-always-ensure t)

(setq inhibit-startup-message t)
(setq initial-scratch-message "")

(require 'server)
(unless (server-running-p)
  (server-start))

(use-package use-package-chords
  :straight t
  :config (key-chord-mode 1))

(use-package lv
  :straight t
)

(use-package hydra
  :demand t
  :straight t
)

(use-package no-littering
  :straight t)
(require 'recentf)

(add-to-list 'recentf-exclude no-littering-etc-directory)

(setq user-full-name "GTrunSec"
      user-mail-address "gtrunsec@hardenedlinux.org")
  (use-package general
    :straight t)

 (use-package diminish
    :straight t)

(use-package auto-package-update
  :straight t
  :config
  (setq auto-package-update-delete-old-versions t
        auto-package-update-hide-results t)
  (auto-package-update-maybe))

;; Don't screw up my files with custom
;(setq custom-file (format "%s/custom.el" user-emacs-directory))
(setq custom-file (no-littering-expand-etc-file-name "custom.el"))

 (load custom-file 'noerror)
 (defalias 'yes-or-no-p 'y-or-n-p)
 ;; Silence!!!!!!

;; (defun gtrun-tangle-byte-compile-org ()
;;   "Tangles main.org and byte compiles ~/.emacs.d/"
;;   (interactive)
;;   (when (equal (buffer-name)
;; 		 (concat "init.org"))
;;      (org-babel-tangle)

;;     ;; Recompile plugins
;;      (byte-recompile-directory (expand-file-name user-emacs-directory) 0)

;;     ;; ;; Recompile init file (FIXME: commented as long as org-mode and matlab problem remains!)
;;     ;; (byte-recompile-file (format "%s/init.el" user-emacs-directory) t 0 nil)
;;     ))

(use-package exec-path-from-shell
  :straight t
  :if (memq window-system '(mac ns))
  :config
  (exec-path-from-shell-initialize)

  )

(use-package xah-fly-key-normal
 :load-path "./setup"
 :if (memq window-system '(mac ns)))

;; (add-to-list 'load-path (expand-file-name "~/.emacs.d/setup"))
;; (require 'xah-fly-key-ergo)

(use-package xah-fly-key-ergo
:if (eq system-type 'gnu/linux)
:load-path "./setup")

(straight-use-package '(lazy-load :type git
                                 :host github
                                 :repo "manateelazycat/lazy-load"))
(require 'lazy-load)
(let (;; temporarily increase `gc-cons-threshold' when loading to speed up startup.
      (gc-cons-threshold most-positive-fixnum)
      ;; Empty to avoid analyzing files when loading remote files.
      (file-name-handler-alist nil))
    ;; Emacs configuration file content is written below.
)

;; (lazy-load-global-keys
;;  '(("M-g" . goto-line-preview)
;;    ;; counsel
;;    ("C-c r" . counsel-recentf)
;;    ("C-c C-r" . ivy-resume)
;;    ("C-c i" . counsel-imenu)
;;    ("C-x b" . ivy-switch-buffer)
;;    ("C-x B" . ivy-switch-buffer-other-window)
;;    ("C-x k" . kill-buffer)
;;    ("C-x C-f" . counsel-find-file)
;;    ("C-x l" . counsel-locate)
;;    ("C-c j" . counsel-git)
;;    ("M-y" . counsel-yank-pop)
;; ))

;; (lazy-load-local-keys
;;  '(("f" . counsel-describe-function)
;;    ("v" . counsel-describe-variable)
;;    ("l" . counsel-info-lookup-symbol))
;;  Help-mode-map)

(lazy-load-set-keys
 '(("M-g" . goto-line-preview)
   ;; counsel
   ("C-c r" . counsel-recentf)
   ("C-c C-s" . counsel-grep-or-swiper)
   ("C-c C-r" . ivy-resume)
   ("C-c i" . counsel-imenu)
   ("C-x b" . ivy-switch-buffer)
   ("C-x B" . ivy-switch-buffer-other-window)
   ("C-x k" . kill-buffer)
   ("C-x C-f" . counsel-find-file)
   ("C-x l" . counsel-locate)
   ("C-c j" . counsel-git)
   ("M-y" . counsel-yank-pop)
   ("C-x j" . counsel-fd-dired-jump)
   ("C-x f" . counsel-fd-file-jump)
))

(lazy-load-set-keys
 '(("f" . counsel-describe-function)
   ("v" . counsel-describe-variable)
   ("l" . counsel-info-lookup-symbol))
 help-mode-map)



 ;; :bind
 ;;  (:map dired-mode-map
 ;;    ("C-o" . dired-omit-mode)
 ;;    ("<C-return>" . dired-open-native)
 ;;    ("e" . dired-open-externally)
 ;;    ("p" . dired-emms-play)
 ;;    ("E" . ora-ediff-files)
 ;;    ("." . hydra-dired/body))

(straight-use-package 'doom-themes)

(load-theme 'doom-vibrant t)
(straight-use-package 'solarized-theme)

(straight-use-package 'doom-modeline)
(add-hook 'after-init-hook #'doom-modeline-mode)

(setq doom-modeline-icon t
      doom-modeline-major-mode-icon t
      doom-modeline-buffer-file-name-style 'truncate-upto-project
      doom-modeline-persp-name t
      doom-modeline-checker-simple-format t

      ;; Whether display environment version or not
      doom-modeline-env-version t

      ;; Or for individual languages
      doom-modeline-env-enable-python t
      doom-modeline-env-enable-go t
      doom-modeline-env-enable-rust t

      ;; Change the executables to use for the language version string
      doom-modeline-env-python-executable "python"
      doom-modeline-env-go-executable "go"
      doom-modeline-env-rust-executable "rustc"

      ;; Whether display irc notifications or not. Requires `circe' package.
      doom-modeline-irc t
      doom-modeline-irc-stylize 'identity

      ;;
      doom-modeline-checker-simple-format t)

(use-package highlight-indent-guides
  :straight t
  :defer 10
  :hook
  (python-mode . highlight-indent-guides-mode)
  :config
  (setq highlight-indent-guides-auto-odd-face-perc 15)
  (setq highlight-indent-guides-auto-even-face-perc 15)
  (setq highlight-indent-guides-auto-character-face-perc 20)
  :custom
  (highlight-indent-guides-method 'character)
    )

;; (straight-use-package 'highlight-indentation) 
;; (require 'highlight-indentation)

(use-package beacon
  :straight t
  :defer 10
  :diminish beacon-mode
  :custom
  (beacon-push-mark 10)
  :config
  (beacon-mode +1))

(use-package all-the-icons
  :straight t)

(use-package all-the-icons-dired
  :straight t)

(use-package all-the-icons-ivy
  :straight t)

(use-package emojify
:straight t
:config
(add-hook 'after-init-hook #'global-emojify-mode)
)

(defun frame-title-format ()
    "Return frame title with current project name, where applicable."
    (let ((file buffer-file-name))
      (if file
          (if (and (bound-and-true-p projectile-mode)
                   (projectile-project-p))
              (concat
               (format "[%s] " (projectile-project-name))
               (replace-regexp-in-string (format "^%s" (projectile-project-p)) "" (file-truename file)))
            (abbreviate-file-name file))
        "%b")))

(when (display-graphic-p)
  (setq frame-title-format '("" " ⨊ GTrun - "
                             ((:eval (frame-title-format))))))

(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)

(use-package eyebrowse
  :straight t
  :config
  (progn
    (define-key eyebrowse-mode-map (kbd "M-1") 'eyebrowse-switch-to-window-config-1)
    (define-key eyebrowse-mode-map (kbd "M-2") 'eyebrowse-switch-to-window-config-2)
    (define-key eyebrowse-mode-map (kbd "M-3") 'eyebrowse-switch-to-window-config-3)
    (define-key eyebrowse-mode-map (kbd "M-4") 'eyebrowse-switch-to-window-config-4)
    (define-key eyebrowse-mode-map (kbd "M-5") 'eyebrowse-switch-to-window-config-5)

    (eyebrowse-mode t)
    (setq eyebrowse-new-workspace t)))

(use-package centaur-tabs
  :straight (centaur-tabs ::type git :host github :repo "ema2159/centaur-tabs")
  :demand t
  :custom-face
  (centaur-tabs-active-bar-face ((t (:background "LightGoldenrod"))))
  :hook
  (after-init . centaur-tabs-mode)
  :config
  (setq centaur-tabs-style "bar")
  (setq centaur-tabs-set-icons t)
  (setq centaur-tabs-set-bar t)
  (setq centaur-tabs-set-bar 'over)
  (setq centaur-tabs-set-modified-marker t)
  (setq centaur-tabs-set-close-button nil)
  (setq centaur-tabs-modified-marker "*")

  ;;  (set-face-attribute 'centaur-tabs-modified-marker-selected nil :foreground (face-background 'doom-modeline-bar))
  :bind
  ("C-c j" .  centaur-tabs-forward-group)
  ("C-c k" .  centaur-tabs-backward-group)
  ("C-c o" . centaur-tabs-switch-group)
  ("s-1" . centaur-tabs-select-visible-tab)
  ("s-2" . centaur-tabs-select-visible-tab)
  ("s-3" . centaur-tabs-select-visible-tab)
  ("s-4" . centaur-tabs-select-visible-tab)
  ("s-5" . centaur-tabs-select-visible-tab)
  ("s-6" . centaur-tabs-select-visible-tab)
  ("s-7" . centaur-tabs-select-visible-tab)
  ("s-8" . centaur-tabs-select-visible-tab)
  ("s-9" . centaur-tabs-select-visible-tab)

  )

(use-package nlinum
        :straight (nlinum :type git :host github :repo "emacsmirror/nlinum")
                                              ;   :disabled t
        :config
        (line-number-mode t)
        (column-number-mode t)
        (global-nlinum-mode t)
        (size-indication-mode t)

        ;; FIX [[http://emacs.1067599.n8.nabble.com/bug-23777-25-0-95-Throwing-error-quot-Selecting-deleted-buffer-quot-in-timer-td400528.html][Emacs - Bugs - bug#23777: 25.0.95; Throwing (error "Selecting deleted buffer") in timer]]

        ;; (defun my-nlinum-mode-hook () 
        ;;   (when nlinum-mode 
        ;;     (setq-local nlinum-format 
        ;;                 (concat "%" (number-to-string 
        ;;                              (ceiling (log (max 1 (count-lines (point-min) 
        ;;                                                                (point-max))) 
        ;;                                            10))) 
        ;;                         "d")))) 
        ;; ;; (defun my-nlinum-mode-hook () 
        ;; ;;     (setq-local nlinum-format 
        ;; ;;                 (concat "%" (number-to-string 
        ;; ;;                              (ceiling (log (max 1 (/ (buffer-size) 80)) 10))) 
        ;; ;;                         "d")))) 
        ;; (add-hook 'nlinum-mode-hook #'my-nlinum-mode-hook)  


        )

      (use-package nlinum-hl
        :straight t
        :after nlinum
                                              ;    :disabled t
        :hook
        (nlinum-mode . (lambda () (setq nlinum-highlight-current-line t))))


;;  (use-package visual-fill-column
;;    :straight t
;;    :defer t
;;    :bind (("C-c t v" . visual-fill-column-mode))
;;    :init
;;    (dolist (hook '(visual-line-mode-hook
;;                    prog-mode-hook
;;                    text-mode-hook
;;  ;;                   help-mode-hook;;未成功
;;                    ))
;; (add-hook hook #'visual-fill-column-mode))
;;    :config (setq-default
;;             ;;visual-fill-column-width 110
;;               ;;           visual-fill-column-center-text t
;;                          visual-fill-column-fringes-outside-margins nil))
      ;; (use-package fill-column-indicator
      ;;   :straight t
      ;;   :config

      ;;   ;; Define a global mode but not sure I am going to use it
      ;;   (define-globalized-minor-mode
      ;;     global-fci-mode fci-mode
      ;;     (lambda ()
      ;;       (fci-mode 1))))


      (setq-default truncate-lines t)

      (defun gtrun/truncate-lines-hook ()
        (setq truncate-lines nil))

      (add-hook 'text-mode-hook 'gtrun/truncate-lines-hook)

(use-package dired-rainbow
   :straight t
   :init
   (eval-after-load 'dired '(require 'dired-rainbow))

   :config

   (dired-rainbow-define audio "#329EE8" ("mp3" "MP3" "ogg" "OGG" "flac" "FLAC" "wav" "WAV"))

   (dired-rainbow-define media "#ce5c00" ("mp3" "mp4" "MP3" "MP4" "avi" "mpg" "flv" "ogg"))
   (dired-rainbow-define video "#455AFC" ("vob" "VOB" "mkv" "MKV" "mpe" "mpg" "MPG" "mp4" "MP4" "ts" "TS" "m2ts"
       "M2TS" "avi" "AVI" "mov" "MOV" "wmv" "asf" "m2v" "m4v" "mpeg" "MPEG" "tp"))

   (dired-rainbow-define html "#4e9a06" ("htm" "html" "xhtml"))
   (dired-rainbow-define xml "DarkGreen" ("xml" "xsd" "xsl" "xslt" "wsdl"))

   (dired-rainbow-define document "#ce5c00" ("doc" "docx" "odt" "pdb" "pdf" "ps" "rtf" "djvu"))
   (dired-rainbow-define image "#ff4b4b" ("jpg" "png" "jpeg" "gif"))

   (dired-rainbow-define sourcefile "#3F82FD" ("el" "groovy" "gradle" "py" "c" "cc" "h" "java" "pl" "rb"))

   (dired-rainbow-define executable "#8cc4ff" ("exe" "msi"))
   (dired-rainbow-define compressed "#ad7fa8" ("zip" "bz2" "tgz" "txz" "gz" "xz" "z" "Z" "jar" "war" "ear" "rar" "sar" "xpi" "apk" "xz" "tar"))
   (dired-rainbow-define packaged "#e6a8df" ("deb" "rpm"))
   (dired-rainbow-define encrypted "LightBlue" ("gpg" "pgp"))

   (dired-rainbow-define-chmod executable-unix "Green" "-.*x.*")

   (dired-rainbow-define log (:inherit default :italic t) ".*\\.log")
   (dired-rainbow-define org "#5F9EA0" (".*\\.org"))
   )

(use-package dired-k
  :straight (dired-k ::type git :host github :repo "syohex/emacs-dired-k")
  :hook (dired-after-readin . dired-k-no-revert)
  :hook (dired-initial-position . dired-k)
 ;:config
 ; (setq dired-k-padding 1)
)

(straight-use-package 'rainbow-mode)

(use-package scrollkeeper
  :straight (scrollkeeper :type git :host github :repo "alphapapa/scrollkeeper.el")
  :general ([remap scroll-up-command] #'scrollkeeper-contents-up
            [remap scroll-down-command] #'scrollkeeper-contents-down))

(use-package emojify
  :straight t
  :hook (circe-chat-mode . emojify-mode)
  :config

  (setq emojify-user-emojis
        '(("(heart)" . (("name" . "Heart")
                     ;   ("image" . "~/.emacs.d/emojis/emojione-v2.2.6-22/2665.png")
                        ("style" . "github")))))

  ;; If emojify is already loaded refresh emoji data
  (when (featurep 'emojify)
    (emojify-set-emoji-data)))

(use-package company-emoji
  :straight t)

(use-package flycheck-status-emoji
  :straight t)

(use-package diff-hl
  :straight (diff-hl :type git :host github :repo "dgutov/diff-hl")
  :hook
  (dired-mode . diff-hl-dired-mode-unless-remote)
  :config
  (global-diff-hl-mode)
  (diff-hl-flydiff-mode)
  (fringe-mode 10)
  )

(defun disable-global-facilities ()
  "Function to disable some utilities globally activated for current buffer"
  (interactive)
  (smartparens-mode 0)
  ;; (nlinum-mode 0)
  )

(use-package smartparens
  :straight t
  :config
  ;; Activate smartparens globally
  (smartparens-global-mode t)
  (show-smartparens-global-mode t)

  ;; Activate smartparens in minibuffer
  (add-hook 'eval-expression-minibuffer-setup-hook #'smartparens-mode)

  ;; Do not pair simple quotes
  (sp-pair "'" nil :actions :rem))

(use-package rainbow-delimiters
  :straight t
  :config
  (custom-set-faces
   '(rainbow-delimiters-mismatched-face ((t (:foreground "white" :background "red" :weight bold))))
   '(rainbow-delimiters-unmatched-face ((t (:foreground "white" :background "red" :weight bold))))

   ;; show parents (in case of rainbow failing !)
   '(show-paren-match ((t (:foreground "white" :background "green" :weight bold))))
   '(show-paren-mismatch ((t (:foreground "white" :background "red" :weight bold)))))

  (add-hook 'prog-mode-hook #'rainbow-delimiters-mode))

;; (straight-use-package 'popwin)
;; (add-hook 'after-init-hook #'popwin-mode)
;; (require 'popwin)

(use-package counsel
   :straight t
   :hook
   (after-init . ivy-mode)
   (counsel-grep-post-action . better-jumper-set-jump)
   :diminish ivy-mode
   :config
   (setq counsel-find-file-ignore-regexp "\\(?:^[#.]\\)\\|\\(?:[#~]$\\)\\|\\(?:^Icon?\\)"
         counsel-describe-function-function #'helpful-callable
         counsel-describe-variable-function #'helpful-variable
         ;; Add smart-casing (-S) to default command arguments:
         counsel-rg-base-command "rg -S --no-heading --line-number --color never %s ."
         counsel-ag-base-command "ag -S --nocolor --nogroup %s"
         counsel-pt-base-command "pt -S --nocolor --nogroup -e %s"
         counsel-find-file-at-point t)
   )

 (use-package ivy
   :straight t
   :custom
   (ivy-re-builders-alist
    '((t . ivy--regex-plus)))
   :config
   (ivy-mode)
   (setq ivy-display-style 'fancy
         ivy-use-virtual-buffers t
         enable-recursive-minibuffers t
         ivy-use-selectable-prompt t)
   (ivy-set-actions
    t
    '(("I" insert "insert")))
   (ivy-set-occur 'ivy-switch-buffer 'ivy-switch-buffer-occur))

 (use-package ivy-rich
   :straight t
   :config
   (ivy-rich-mode 1)
   (setq ivy-format-function #'ivy-format-function-line))
 ;;[[https://github.com/gilbertw1/better-jumper][gilbertw1/better-jumper: A configurable jump list implementation for Emacs]]


(use-package better-jumper
   :straight t
   )

(setq ivy-display-style 'fancy)

(straight-use-package '(point-history 
                        :type git 
                        :host github 
                        :repo "blue0513/point-history"))


(setq point-history-mode 1)

(straight-use-package '(ivy-point-history 
                        :type git 
                        :host github 
                        :repo "SuzumiyaAoba/ivy-point-history"))
(setq point-history-ignore-buffer "^ \\*Minibuf\\|^ \\*point-history-show*")
(setq point-history-ignore-major-mode '(emacs-lisp-mode ruby-mode))

(use-package swiper
  :ensure nil
  :bind
  (("C-s" . swiper-isearch)
   :map swiper-map
   ("M-q" . swiper-query-replace)
   ("C-l". swiper-recenter-top-bottom)
   ("C-'" . swiper-avy))
  :custom
  (counsel-grep-swiper-limit 20000)
  (counsel-rg-base-command
   "rg -i -M 120 --no-heading --line-number --color never %s .")
  (counsel-grep-base-command
   "rg -i -M 120 --no-heading --line-number --color never '%s' %s"))

(use-package company
  :straight t
  :hook
  (emacs-lisp-mode . (lambda () (add-to-list (make-local-variable 'company-backends) '(company-elisp))))
  :config

  ;; Global
  (setq company-idle-delay 1
        company-minimum-prefix-length 1
        company-show-numbers t
        company-tooltip-limit 20)

  ;; Facing
  (unless (face-attribute 'company-tooltip :background)
    (set-face-attribute 'company-tooltip nil :background "black" :foreground "gray40")
    (set-face-attribute 'company-tooltip-selection nil :inherit 'company-tooltip :background "gray15")
    (set-face-attribute 'company-preview nil :background "black")
    (set-face-attribute 'company-preview-common nil :inherit 'company-preview :foreground "gray40")
    (set-face-attribute 'company-scrollbar-bg nil :inherit 'company-tooltip :background "gray20")
    (set-face-attribute 'company-scrollbar-fg nil :background "gray40"))

  ;; Default backends
  (setq company-backends '((company-files
                            company-keywords
                            company-capf
                            company-yasnippet)
                           (company-abbrev company-dabbrev)))
  ;; Use the tab-and-go frontend.
  ;; Allows TAB to select and complete at the same time.


  (defun company-smart-complete ()
    (interactive)
    (setq company-echo-metadata-frontend-bypass t)
    (cond
     (company-selection-changed
      (company-complete-selection))
     (company-candidates
      (company-select-next)
      (company-complete-selection))
     (t
      (company-auto-begin)
      (company-select-next))))


  (add-to-list 'company-backends #'company-tabnine)
  (add-hook 'comppany-mode #' company-smart-complete)
  ;; Activating globally
  (global-company-mode t)
  )

(straight-use-package 'company-quickhelp)
(setq company-quickhelp-mode 1)

(straight-use-package '(company-englisp-helper
			   :type git
			   :host github
			   :repo "manateelazycat/company-english-helper"))
   (require 'company-english-helper)

(straight-use-package '(emacs-powerthesaurus
                        :type git
                        :host github
                        :repo "SavchenkoValeriy/emacs-powerthesaurus"))

(use-package company-tabnine
:straight t
:config
(setq company-tabnine--disable-next-transform nil)
(defun my-company--transform-candidates (func &rest args)
(if (not company-tabnine--disable-next-transform)
    (apply func args)
    (setq company-tabnine--disable-next-transform nil)
    (car args)))

(defun my-company-tabnine (func &rest args)
(when (eq (car args) 'candidates)
    (setq company-tabnine--disable-next-transform t))
(apply func args))

(advice-add #'company--transform-candidates :around #'my-company--transform-candidates)
(advice-add #'company-tabnine :around #'my-company-tabnine))

(use-package helm
  :straight t
  :config
  (setq helm-scroll-amount 4 ; scroll 4 lines other window using M-<next>/M-<prior>
        helm-quick-update t ; do not display invisible candidates
        helm-idle-delay 0.01 ; be idle for this many seconds, before updating in delayed sources.
        helm-input-idle-delay 0.01 ; be idle for this many seconds, before updating candidate buffer
        helm-show-completion-display-function #'helm-show-completion-default-display-function
        helm-split-window-default-side 'below ;; open helm buffer in another window
        helm-split-window-inside-p t ;; open helm buffer inside current window, not occupy whole other window
        helm-candidate-number-limit 200 ; limit the number of displayed canidates
        helm-move-to-line-cycle-in-source nil ; move to end or beginning of source when reaching top or bottom of source.
        )
  )

(straight-use-package 'imenu-list)
(require 'imenu-list)
(global-set-key (kbd "C-'") #'imenu-list-smart-toggle)

(defun set-icon-fonts (CODE-FONT-ALIST)
   "Utility to associate many unicode points with specified fonts."
   (--each CODE-FONT-ALIST
     (-let (((font . codes) it))
       (--each codes
         (set-fontset-font t `(,it . ,it) font)))))

 (defun load-default-fonts ()
   ;;(setq doom-font (font-spec :family "Fantasque Sans Mono" :size 25))
   ;;(setq default-frame-alist '((font . "Iosevka-14")))

   ;; (set-fontset-font "fontset-default" 'unicode "Fantasque Sans Mono-22")
   ;; (set-face-font 'default "Fantasque Sans Mono-23")



   ;; The icons you see are not the correct icons until this is evaluated!
   (set-icon-fonts
    '(("fontawesome"
       ;;                         
       #xf07c #xf0c9 #xf0c4 #xf0cb #xf017 #xf101)

      ("all-the-icons"
       ;;    
       #xe907 #xe928)

      ("github-octicons"
       ;;                        
       #xf091 #xf059 #xf076 #xf075 #xf016 #xf00a)

      ("Symbola"
       ;; 𝕊    ⨂      ∅      ⟻    ⟼     ⊙      𝕋       𝔽
       #x1d54a #x2a02 #x2205 #x27fb #x27fc #x2299 #x1d54b #x1d53d
       ;; 𝔹    𝔇       𝔗
       #x1d539 #x1d507 #x1d517))))


 (defun load-fonts (frame)
   (select-frame frame)
   (load-default-fonts))

 (if (daemonp)
     (add-hook 'after-make-frame-functions #'load-fonts)
   (load-default-fonts))

(use-package amx
  :straight t
  :hook
  (after-init . amx-mode))

(defvar my-cache-dir  "~/.emacs.d/.cache")
(setq amx-save-file (concat my-cache-dir "amx-items"))

;; (straight-use-package 'multiple-cursors)
;; (require 'multiple-cursors)

(straight-use-package 'iedit)

(use-package maple-iedit
  :ensure nil
  :straight (maple-iedit :type git
                         :host github
                         :repo "honmaple/emacs-maple-iedit")
  :commands (maple-iedit-match-all maple-iedit-match-next maple-iedit-match-previous)
  :config
  (delete-selection-mode t)
  (setq maple-iedit-ignore-case t)
  (defhydra maple/iedit ()
    ("n" maple-iedit-match-next "next")
    ("t" maple-iedit-skip-and-match-next "skip and next")
    ("T" maple-iedit-skip-and-match-previous "skip and previous")
    ("p" maple-iedit-match-previous "prev"))
  :bind (:map maple-iedit-mode-keymap
              ("," . maple-iedit-match-next)
              ("." . maple-iedit-match-previous)
              (";" . maple-iedit-skip-and-match-next)
              ("'" . maple-iedit-skip-and-match-previous)
              )
  )

(use-package whitespace
  :straight t
  :diminish whitespace-mode
  :hook (prog-mode . whitespace-mode)
  :custom
  (whitespace-line-column 80)
  (whitespace-style '(face lines-tail)))

(use-package dtrt-indent
  :straight t
  :diminish t
  :config
  (dtrt-indent-mode +1))

(use-package hungry-delete
:straight t
:config
(global-hungry-delete-mode))

(straight-use-package 'prescient)
(straight-use-package 'ivy-prescient)
(straight-use-package 'company-prescient)

(add-hook 'company-mode-hook #'company-prescient-mode)
;;add pinyin to ivy-re-build-alist
;;(add-hook 'ivy-mode-hook #'ivy-prescient-mode)
(require 'prescient)
(add-hook 'after-init-hook #'prescient-persist-mode)

(defvar my-private-dir  "~/.emacs.d/private")
;; (defvar +snippet-dir (format "%s/snippets" my-private-dir))

  (use-package yasnippet
    :straight t
    :commands (yas-minor-mode-on yas-expand yas-expand-snippet yas-lookup-snippet
             yas-insert-snippet yas-new-snippet yas-visit-snippet-file)
    :hook
    ;; (yas-minor-mode . yas-reload-all)
    (after-init . yas-reload-all)
    ((text-mode conf-mode snippet-mode prog-mode) . yas-minor-mode-on)
    ;; :config
    ;; (defun +snippets-initialize ()
    ;;   (add-to-list 'yas-snippet-dirs '+snippet-dir t)
    ;;   (yas-load-directory +snippet-dir t))

    ;; (eval-after-load 'yasnippet '(+snippets-initialize))

    )


  ;; Connect with ivy to have a list on demand
  (use-package ivy-yasnippet
    :straight t)
  (use-package yasnippet-snippets
    :straight t)
  (use-package auto-yasnippet
    :straight t
    :config
    (setq aya-persist-snippets-dir (concat my-private-dir "auto-snippets/"))
)
  (use-package doom-snippets
    :load-path "private/emacs-snippets/"
    :after yasnippet)

(use-package yatemplate
  :straight t
  :after yasnippet
  :config

  ;; Define template directory
  (setq yatemplate-dir (concat user-emacs-directory "private/templates"))

  ;; Coupling with auto-insert
  (setq auto-insert-alist nil)
  (yatemplate-fill-alist)
  (add-hook 'find-file-hook 'auto-insert)
  )

;; (use-package snails
;;   :load-path "./setup/snails"
;;   :config
;;   (define-key snails-mode-map [remap next-line] #'snails-select-next-item)
;;   (add-hook 'snails-mode-hook #'xah-fly-insert-mode-activate)
;;   )

(straight-use-package 'request)
(require 'request)

(straight-use-package '(color-rg
                             :type git
                             :host github
                             :repo "manateelazycat/color-rg"))

(define-key isearch-mode-map (kbd "M-s M-s") 'isearch-toggle-color-rg)
(require 'color-rg)

(use-package flycheck
  :straight t
  :config
  (setq-default flycheck-disabled-checkers '(emacs-lisp-checkdoc))

  (flycheck-define-checker proselint
    "A linter for prose."
    :command ("proselint" source-inplace)
    :error-patterns
    ((warning line-start (file-name) ":" line ":" column ": "
              (id (one-or-more (not (any " "))))
              (message) line-end))
    :modes (text-mode markdown-mode gfm-mode org-mode))
  )

(use-package flycheck-stack
  :straight t
  :after flycheck)

;;(remove-hook 'find-file-hook 'flymake-find-file-hook)

(straight-use-package 'rg)
(require 'rg)
(rg-enable-default-bindings)

(straight-use-package  '(awesome-pair :type git 
                                      :host github 
                                      :repo "manateelazycat/awesome-pair"))
(require 'awesome-pair)
(dolist (hook (list
               'c-mode-common-hook
               'c-mode-hook
               'c++-mode-hook
               'java-mode-hook
               'haskell-mode-hook
               'emacs-lisp-mode-hook
               'lisp-interaction-mode-hook
               'lisp-mode-hook
               'maxima-mode-hook
               'ielm-mode-hook
               'sh-mode-hook
               'makefile-gmake-mode-hook
               'php-mode-hook
               'python-mode-hook
               'js-mode-hook
               'go-mode-hook
               'qml-mode-hook
               'jade-mode-hook
               'css-mode-hook
               'ruby-mode-hook
               'coffee-mode-hook
               'rust-mode-hook
               'qmake-mode-hook
               'lua-mode-hook
               'swift-mode-hook
               'minibuffer-inactive-mode-hook
               ))
  (add-hook hook '(lambda () (awesome-pair-mode 1))))

(define-key awesome-pair-mode-map (kbd "(") 'awesome-pair-open-round)
(define-key awesome-pair-mode-map (kbd "[") 'awesome-pair-open-bracket)
(define-key awesome-pair-mode-map (kbd "{") 'awesome-pair-open-curly)
(define-key awesome-pair-mode-map (kbd ")") 'awesome-pair-close-round)
(define-key awesome-pair-mode-map (kbd "]") 'awesome-pair-close-bracket)
(define-key awesome-pair-mode-map (kbd "}") 'awesome-pair-close-curly)
(define-key awesome-pair-mode-map (kbd "=") 'awesome-pair-equal)

(define-key awesome-pair-mode-map (kbd "%") 'awesome-pair-match-paren)
(define-key awesome-pair-mode-map (kbd "\"") 'awesome-pair-double-quote)

(define-key awesome-pair-mode-map (kbd "SPC") 'awesome-pair-space)

(define-key awesome-pair-mode-map (kbd "M-o") 'awesome-pair-backward-delete)
(define-key awesome-pair-mode-map (kbd "C-d") 'awesome-pair-forward-delete)
(define-key awesome-pair-mode-map (kbd "C-k") 'awesome-pair-kill)

(define-key awesome-pair-mode-map (kbd "M-\"") 'awesome-pair-wrap-double-quote)
(define-key awesome-pair-mode-map (kbd "M-[") 'awesome-pair-wrap-bracket)
(define-key awesome-pair-mode-map (kbd "M-{") 'awesome-pair-wrap-curly)
(define-key awesome-pair-mode-map (kbd "M-(") 'awesome-pair-wrap-round)
(define-key awesome-pair-mode-map (kbd "M-)") 'awesome-pair-unwrap)

(define-key awesome-pair-mode-map (kbd "M-p") 'awesome-pair-jump-right)
(define-key awesome-pair-mode-map (kbd "M-n") 'awesome-pair-jump-left)
(define-key awesome-pair-mode-map (kbd "M-:") 'awesome-pair-jump-out-pair-and-newline)

;; (use-package fuz
;; :load-path "./setup/fuz.el"
;; :config
;; (with-eval-after-load 'helm
;;   (require 'helm-fuz)
;;   (helm-fuz-mode))
;; (setq ivy-sort-matches-functions-alist '((t . ivy-fuz-sort-fn)))
;; (setq ivy-re-builders-alist '((t . ivy-fuz-regex-fuzzy)))

;; (with-eval-after-load 'ivy
;;   (require 'ivy-fuz)
;;   (add-to-list 'ivy-highlight-functions-alist '(ivy-fuz-regex-fuzzy . ivy-fuz-highlight-fn)))
;; )

(use-package discover
  :straight (discover :type git 
                      :host github 
                      :repo "mickeynp/discover.el")
  :config
  (global-discover-mode 1)


  )

(use-package projectile
    :straight t
    :config
    ;; Global configuration
    (setq projectile-switch-project-action 'neotree-projectile-action
          projectile-enable-caching t
          projectile-create-missing-test-files t
          projectile-switch-project-action #'projectile-commander
          projectile-ignored-project-function 'file-remote-p)

    ;; Defining some helpers
    (def-projectile-commander-method ?s
      "Open a *shell* buffer for the project."
      ;; This requires a snapshot version of Projectile.
      (projectile-run-shell))

    (def-projectile-commander-method ?c
      "Run `compile' in the project."
      (projectile-compile-project nil))

    (def-projectile-commander-method ?\C-?
      "Go back to project selection."
      (projectile-switch-project))

    ;; Keys
    (define-key projectile-mode-map (kbd "C-x p") 'projectile-command-map)

    ;; Activate globally
    (projectile-mode)
)

(use-package dired
  :ensure nil
  :config
  (defhydra hydra-dired (:hint nil :color pink)

    "
    _+_ mkdir          _v_iew           _m_ark             _(_ details        _i_nsert-subdir    wdired
    _C_opy             _O_ view other   _U_nmark all       _)_ omit-mode      _$_ hide-subdir    C-x C-q : edit
    _D_elete           _o_pen other     _u_nmark           _l_ redisplay      _w_ kill-subdir    C-c C-c : commit
    _R_ename           _M_ chmod        _t_oggle           _g_ revert buf     _e_ ediff          C-c ESC : abort
    _Y_ rel symlink    _G_ chgrp        _E_xtension mark   _s_ort             _=_ pdiff
    _S_ymlink          ^ ^              _F_ind marked      _._ toggle hydra   \\ flyspell
    _r_sync            ^ ^              ^ ^                ^ ^                _?_ summary
    _z_ compress-file  _A_ find regexp
    _Z_ compress       _Q_ repl regexp

    T - tag prefix
    "
    ("\\" dired-do-ispell)
    ("(" dired-hide-details-mode)
    (")" dired-omit-mode)
    ("+" dired-create-directory)
    ("=" diredp-ediff)         ;; smart diff
    ("?" dired-summary)
    ("$" diredp-hide-subdir-nomove)
    ("A" dired-do-find-regexp)
    ("C" dired-do-copy)        ;; Copy all marked files
    ("D" dired-do-delete)
    ("E" dired-mark-extension)
    ("e" dired-ediff-files)
    ("F" dired-do-find-marked-files)
    ("G" dired-do-chgrp)
    ("g" revert-buffer)        ;; read all directories again (refresh)
    ("i" dired-maybe-insert-subdir)
    ("l" dired-do-redisplay)   ;; relist the marked or singel directory
    ("M" dired-do-chmod)
    ("m" dired-mark)
    ("O" dired-display-file)
    ("o" dired-find-file-other-window)
    ("Q" dired-do-find-regexp-and-replace)
    ("R" dired-do-rename)
    ("r" dired-do-rsynch)
    ("S" dired-do-symlink)
    ("s" dired-sort-toggle-or-edit)
    ("t" dired-toggle-marks)
    ("U" dired-unmark-all-marks)
    ("u" dired-unmark)
    ("v" dired-view-file)      ;; q to exit, s to search, = gets line #
    ("w" dired-kill-subdir)
    ("Y" dired-do-relsymlink)
    ("z" diredp-compress-this-file)
    ("Z" dired-do-compress)
    ("q" nil)
    ("." nil :color blue))


  :init
  (defun ora-ediff-files ()
    (interactive)
    (let ((files (dired-get-marked-files))
          (wnd (current-window-configuration)))
      (if (<= (length files) 2)
          (let ((file1 (car files))
                (file2 (if (cdr files)
                           (cadr files)
                         (read-file-name
                          "file: "
                          (dired-dwim-target-directory)))))
            (if (file-newer-than-file-p file1 file2)
                (ediff-files file2 file1)
              (ediff-files file1 file2))
            (add-hook 'ediff-after-quit-hook-internal
                      (lambda ()
                        (setq ediff-after-quit-hook-internal nil)
                        (set-window-configuration wnd))))
        (error "no more than 2 files should be marked"))))

  :config

  (setq-default dired-omit-files "^\\.[^.]+"
                dired-omit-mode t)

  ;; Adapt ls lisp format
  (if (boundp 'ls-lisp-ignore-case)
      (setq ls-lisp-ignore-case t))
  (if (boundp 'ls-lisp-dirs-first)
      (setq ls-lisp-dirs-first t))
  (if (boundp 'ls-lisp-use-localized-time-format)
      (setq ls-lisp-use-localized-time-format t))
  (if (boundp 'ls-lisp-format-time-list)
      (setq ls-lisp-format-time-list '("%Y-%m-%d %H:%M" "%Y-%m-%d %H:%M")))

  (put 'dired-find-alternate-file 'disabled nil)

  (setq auto-compression-mode t
        dired-details-hidden-string "[...]")

 ;; (let ((args (list "-aBhl" "--group-directories-first")))
 ;;    (when IS-BSD
 ;;      ;; Use GNU ls as `gls' from `coreutils' if available. Add `(setq
 ;;      ;; dired-use-ls-dired nil)' to your config to suppress the Dired warning
 ;;      ;; when not using GNU ls.
 ;;      (if-let* ((gls (executable-find "gls")))
 ;;          (setq insert-directory-program gls)
 ;;        ;; BSD ls doesn't support --group-directories-first
 ;;        (setq args (delete "--group-directories-first" args))))
 ;;    (setq dired-listing-switches (string-join args " ")))
  )

(use-package autorevert
  :straight f
  :diminish t
  :hook
  (dired-mode . auto-revert-mode)
  :config
  (global-auto-revert-mode +1)
  :custom
  (auto-revert-verbose nil))

;;Sort directories first
(setq dired-listing-switches "-aBhl  --group-directories-first")

;;Enable dired-dwim
;;This allows dired to copy/paste/move files over to the other directory in a separate window pane quickly.

(setq dired-dwim-target t)

;Recursive Copying and Deleting
(setq dired-recursive-copies (quote always))
(setq dired-recursive-deletes (quote top))

;;allow editing of permissions
(use-package wdired
  :commands wdired-mode wdired-change-to-wdired-mode
  :custom
  (wdired-allow-to-change-permissions t))

(use-package dired-narrow
  :bind (:map dired-mode-map
              ("N" . dired-narrow-fuzzy)))
(use-package dired-x
  :ensure nil
  :hook (dired-mode . dired-omit-mode)
  :config
  (setq dired-omit-verbose nil))


(use-package counsel-fd
:load-path "./setup")

(use-package diredfl
:straight t
:hook (dired-mode . diredfl-mode))

(use-package treemacs
  :straight t
  :bind (:map global-map
              ([f8]        . treemacs-toggle))
  :config
  (setq treemacs-follow-after-init          t
        treemacs-width                      35
        treemacs-indentation                2
        treemacs-git-integration            t
        treemacs-collapse-dirs              3
        treemacs-silent-refresh             nil
        treemacs-change-root-without-asking nil
        treemacs-sorting                    'alphabetic-desc
        treemacs-show-hidden-files          t
        treemacs-never-persist              nil
        treemacs-is-never-other-window      nil
        treemacs-goto-tag-strategy          'refetch-index)

  (treemacs-follow-mode t)
  (treemacs-filewatch-mode t))

(use-package treemacs-magit
   :after treemacs magit
   :straight t)

(use-package treemacs-projectile
  :straight t
  :after treemacs projectile
  :config
  (setq treemacs-header-function #'treemacs-projectile-create-header))

(use-package treemacs-icons-dired
  :after treemacs dired
  :straight t
  :config (treemacs-icons-dired-mode))

(use-package lsp-mode
       :straight t
       :commands lsp
       :hook
       (lsp-after-open-hook . lsp-enable-imenu)
       :custom
       (lsp-message-project-root-warning t)
       :init
       (require 'lsp-clients)
       (add-hook 'python-mode-hook #'lsp)
       (add-hook 'c++-mode-hook #'lsp)
       (add-hook 'c-mode-hook #'lsp)
       (add-hook 'go-mode-hook #'lsp)
       :config
       (setq lsp-auto-guess-root t)
       (setq lsp-enable-eldoc t)
       (setq lsp-enable-completion-at-point t))

     (use-package lsp-ui
       :straight t
       :after lsp-mode
       :commands lsp-ui-mode
       :hook
       (lsp-mode . lsp-ui-mode)
       :config
       (define-key lsp-ui-mode-map [remap xref-find-definitions] #'lsp-ui-peek-find-definitions)
       (define-key lsp-ui-mode-map [remap xref-find-references] #'lsp-ui-peek-find-references)
       :bind
       (:map lsp-ui-peek-mode-map
             ("h" . lsp-ui-peek--select-prev-file)
             ("j" . lsp-ui-peek--select-next)
             ("k" . lsp-ui-peek--select-prev)
             ("l" . lsp-ui-peek--select-next-file)
             :map lsp-ui-imenu-mode-map
             ("h" . lsp-ui-imenu--jump)
             ("j" . lsp-ui-imenu--visit)
             ("l" . lsp-ui-imenu--view))

       )

     ;; (use-package company-lsp
     ;;   :straight t
     ;;   :after company lsp-mode latex-mode
     ;;   :config
     ;;   (add-to-list 'company-backends 'company-lsp)
     ;; )


     ;; (use-package lsp-treemacs
     ;;   :straight (lsp-treemacs :type git :host github :repo "emacs-lsp/lsp-treemacs")
     ;;   :commands lsp-treemacs-errors-list)
(straight-use-package 'lsp-treemacs)

;; (use-package dap-mode
;; :straight t
;; :after lsp
;; :config
;; (dap-mode 1)
;; (dap-ui-mode 1)
;; (require 'dap-python)
;; (require 'dap-go)
;; )

(straight-use-package 'package-lint)

;; Pretty print for lisp
(straight-use-package 'ipretty)

(straight-use-package 'anaphora)
(require 'anaphora)

(straight-use-package '(prism :type git
                                 :host github
                                 :repo "alphapapa/prism.el"))
(require 'prism)
(require 'solarized-theme)
(prism-set-faces :num 24
  :desaturations (list 20 40) :lightens (list 0 20 40)
  :colors (solarized-with-color-variables 'dark
	    (list red orange yellow green blue cyan violet magenta)))

(use-package slime
:straight t
:config
(setq inferior-lisp-program "/usr/local/bin/sbcl")
(setq slime-contribs '(slime-fancy)))

(straight-use-package 'ess)
  ;;(require 'ess-site)
(require 'ess-r-mode)
(when (not (boundp 'ess-r-mode-hook))
  (setq ess-r-mode-hook nil ))
(defun emacsmate-turn-on-ess-eldoc ()
  (require 'ess-eldoc))
(add-hook 'ess-r-mode-hook 'emacsmate-turn-on-ess-eldoc)
(autoload 'R-mode "ess-site" "ESS" 't)

(add-to-list 'auto-mode-alist '("\\.[rR]\\'" . ess-r-mode))

    (defun gtrun/add-company-backend-ess ()
      (pop company-backends)
      (setq-local company-backends
                  (append '((company-R-args company-R-objects company-R-library
                                            company-tabnine))
                          company-backends)))

    (add-hook 'ess-r-mode-hook 'gtrun/add-company-backend-ess)

 ;; (require 'ess-r-mode)
    ;; (straight-use-package 'ess)
    ;; (require 'ess)
    (straight-use-package 'ess-R-data-view)
    (require 'ess-R-data-view)

(use-package go-mode
:straight t
:config
(autoload 'go-mode "go-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.go\\'" . go-mode)))

(use-package python
  :ensure nil
  :config

(add-hook 'python-mode-hook 
      (lambda () 
        (unless (eq buffer-file-name nil) (flymake-mode 1)) ;dont invoke flymake on temporary buffers for the interpreter
        (flycheck-mode 1)
        (outline-minor-mode -1)))

  )

(use-package lsp-python-ms
  :straight t
  :demand t
  :hook (python-mode . lsp))

(use-package tex-site
  :ensure nil
  :after (tex latex)
  :hook
  (LaTeX-mode . turn-off-auto-fill)
  (LaTeX-mode . (lambda () (TeX-fold-mode t)))
  (LaTeX-mode . flyspell-mode)
  (LaTeX-mode . LaTeX-math-mode)
  (LaTeX-mode . outline-minor-mode)
  (LaTeX-mode . TeX-source-correlate-mode)
  :config
  ;; Pdf activated by default
  (require 'tex)

  ;; Diverse
  (setq-default TeX-master nil)
  (setq TeX-parse-self t
        TeX-auto-save t)
  )


(defun my-latex-mode-setup ()
  (setq-local company-backends
              (append '((company-math-symbols-latex company-latex-commands))
                      company-backends)))

(add-hook 'TeX-mode-hook 'my-latex-mode-setup)
(setq tex-compile-commands '(("xelatex %r")))
(setq tex-command "xelatex")
(setq org-latex-compiler "xelatex")

(setq-default TeX-engine 'xetex)
(setq-default TeX-PDF-mode t)

(require 'ox-latex)
  (add-to-list 'org-latex-classes '("ctexart" "\\documentclass[11pt]{ctexart}

  [NO-DEFAULT-PACKAGES]
    \\usepackage[utf8]{inputenc}
    \\usepackage[T1]{fontenc}
    \\usepackage{fixltx2e}
    \\usepackage{graphicx}
    \\usepackage{longtable}
    \\usepackage{float}
    \\usepackage{wrapfig}
    \\usepackage{rotating}
    \\usepackage[normalem]{ulem}
    \\usepackage{amsmath}
    \\usepackage{textcomp}
    \\usepackage{marvosym}
    \\usepackage{wasysym}
    \\usepackage{amssymb}
    \\usepackage{booktabs}
    \\usepackage[colorlinks,linkcolor=black,anchorcolor=black,citecolor=black]{hyperref}
    \\tolerance=1000
    \\usepackage{listings}
    \\usepackage{xcolor}
    \\lstset{
    %行号
    numbers=left,
    %背景框
    framexleftmargin=10mm,
    frame=none,
    %背景色
    %backgroundcolor=\\color[rgb]{1,1,0.76},
    backgroundcolor=\\color[RGB]{245,245,244},
    %样式
    keywordstyle=\\bf\\color{blue},
    identifierstyle=\\bf,
    numberstyle=\\color[RGB]{0,192,192},
    commentstyle=\\it\\color[RGB]{0,96,96},
    stringstyle=\\rmfamily\\slshape\\color[RGB]{128,0,0},
    %显示空格
    showstringspaces=false
    }
    "
                                            ("\\section{%s}" . "\\section*{%s}")
                                            ("\\subsection{%s}" . "\\subsection*{%s}")
                                            ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                                            ("\\paragraph{%s}" . "\\paragraph*{%s}")
                                            ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))

          ;; {{ export org-mode in Chinese into PDF
          ;; @see http://freizl.github.io/posts/tech/2012-04-06-export-orgmode-file-in-Chinese.html
          ;; and you need install texlive-xetex on different platforms
          ;; To install texlive-xetex:
          ;;    `sudo USE="cjk" emerge texlive-xetex` on Gentoo Linux
          ;; }}
          (setq org-latex-default-class "ctexart")
          (setq org-latex-pdf-process
                '(
                  "xelatex -interaction nonstopmode -output-directory %o %f"
                  "xelatex -interaction nonstopmode -output-directory %o %f"
                  "xelatex -interaction nonstopmode -output-directory %o %f"
                  "rm -fr %b.out %b.log %b.tex auto"))

(use-package company-math
:straight t
:hook
  (latex-mode . (lambda () (add-to-list (make-local-variable 'company-backends) '(company-math-symbols-unicode))))
  (org-mode . (lambda () (add-to-list (make-local-variable 'company-backends) '(company-math-symbols-unicode))))
)

(use-package bro-mode
  :load-path "./setup"
  :config
  (setenv "BROPATH" "/usr/local/zeek/bin:/usr/local/zeek/share/zeek")
  (setq bro-event-bif "/usr/local/zeek/share/zeek/base/bif/event.bif.zeek")
  (setq bro-tracefiles "~/project/Bro-Script")
  :bind
  (:map bro-mode-map
        ("C-c C-c" . bro-run)))

(straight-use-package 'jeison)

(use-package space-vinegar
:load-path ("./setup"))

(straight-use-package 'git)

(defun org-git-version ()
  "The Git version of org-mode.
Inserted by installing org-mode or when a release is made."
  (require 'git)
  (let ((git-repo (expand-file-name
                   "straight/repos/org/" user-emacs-directory)))
    (string-trim
     (git-run "describe"
              "--match=release\*"
              "--abbrev=6"
              "HEAD"))))

(defun org-release ()
  "The release version of org-mode.
Inserted by installing org-mode or when a release is made."
  (require 'git)
  (let ((git-repo (expand-file-name
                   "straight/repos/org/" user-emacs-directory)))
    (string-trim
     (string-remove-prefix
      "release_"
      (git-run "describe"
               "--match=release\*"
               "--abbrev=0"
               "HEAD")))))
(provide 'org-version)

(straight-use-package 'org)

  (push (expand-file-name "~/.emacs.d/straight/repos/org/contrib/lisp") load-path)

    (require 'org-mac-link)


        (define-key org-mode-map [remap org-set-tags-command] #'counsel-org-tag)
        ;; Global
        (setq org-startup-indented t
              org-enforce-todo-dependencies t
              org-cycle-separator-lines 2
              org-blank-before-new-entry '((heading) (plain-list-item . auto))
              org-insert-heading-respect-content nil
              org-reverse-note-order nil
              org-show-following-heading t
              org-show-hierarchy-above t
              org-show-siblings '((default))
              org-id-method 'uuidgen
              org-deadline-warning-days 30
              org-table-export-default-format "orgtbl-to-csv"
              org-src-window-setup 'other-window
              org-clone-delete-id t
              org-cycle-include-plain-lists t
              org-src-fontify-natively t
              org-src-tab-acts-natively t
              org-display-inline-images nil
              org-hide-emphasis-markers t)

        ;; Activate spelling
        (add-hook 'org-mode 'flyspell-mode)
        (add-to-list 'ispell-skip-region-alist '("^#+begin_src" . "^#+end_src"))

        ;; Todo part
        (setq org-todo-keywords '(;; Baseline sequence
                                  (sequence "☞ TODO(t)" "☟ NEXT(n)" "✰ Important(i)" "⚑ WAITING(w)"  "💬 MEETING(M)" "|" "✔ DONE(d!)" "✘ CANCELED(c@)" "⚔ STARTED(s)")

                                  ;; Specific "to complete
                                  (sequence "📄 REVIEW(r)" "📚 RELEASE(R)" " 📩 MAIL(m)" "|" "❤ Love(l)")

                                  ;; Note information
                                  (sequence "|" "✍ NOTE(N)" " 🔮 EVENT(E)" "☕ BREAK(b)"))

              org-todo-state-tags-triggers '(("CANCELLED" ("CANCELLED" . t))
                                             ("WAITING"   ("WAITING"   . t))
                                             ("STARTED" ("STARTED" . t)))

              ;; Priority definition
              org-highest-priority ?A
              org-lowest-priority ?E
              org-default-priority ?C

              ;; Archiving
              org-archive-mark-done t
              org-log-done 'time
                                                ;org-archive-location "%s_archive::* Archived Tasks"
              org-time-clocksum-format '(:hours "%d" :require-hours t :minutes ":%02d" :require-minutes t)
              org-archive-location (concat "%s_archive_" (format-time-string "%Y" (current-time)) "::")

              ;; Refiling
              org-refile-targets '((org-agenda-files . (:maxlevel . 6)))
              org-completion-use-ido nil
              org-refile-use-outline-path 'file
              org-outline-path-complete-in-steps nil
              org-refile-allow-creating-parent-nodes 'confirm)

        ;; Change task state to STARTED when clocking in
        (setq org-clock-in-switch-to-state "⚔ STARTED")
        ;; Save clock data and notes in the LOGBOOK drawer
        (setq org-clock-into-drawer t)
        ;; Removes clocked tasks with 0:00 duration
        (setq org-clock-out-remove-zero-time-clocks t) 
        ;; Show the clocked-in task - if any - in the header line
        (setq org-ellipsis "☯")
        (setq org-todo-keyword-faces
              '(("☞ TODO" . (:foreground "#ff39a3" :weight bold))
                ("⚔ STARTED"  . "#E35DBF")
                ("✘ CANCELED" . (:foreground "white" :background "#4d4d4d" :weight bold))
                ("⚑ WAITING" . "pink")
                ("☕ BREAK" . "gray")
                ("❤ Love" . (:foreground "blue" 
                                         ;; :background "#7A586A"
                                         :weight bold))
                ("✔ DONE" . "#008080")))

        (org-babel-do-load-languages 'org-babel-load-languages
                                     '((emacs-lisp . t)
                                       (dot . t)
                                       (ditaa . t)
                                       (R . t)
                                       (python . t)
                                       (gnuplot . t)
                                       (lisp . t)
                                       (shell . t)
                                       (org . t)
                                       (plantuml . t)
                                       (latex . t)))

(straight-use-package '(helm-deft :type git
                                  :host github
                                  :repo "dfeich/helm-deft"))

(require 'helm-deft)
(setq helm-deft-extension "org")
(setq helm-deft-dir-list '(
                           "~/org-notes/art"
                           "~/org-notes/NSM-GTD"
                           "~/org-notes/post"
                           "~/org-notes/course"
                           "~/project/gtrun-profile/dotfiles/wallpaper"
                           "~/project/global-profile/global-doc"
                           ))

(use-package org-starter
  :straight t
  :config
  (org-starter-def "~/org-notes"
    :files
    ("gtd.org" :agenda t :key "g" :refile (:maxlevel . 5))
    ("notes.org" :agenda t :key "n" :refile (:maxlevel .5 ))
    ("myself.org" :agenda t)
    ("NSM-GTD/workflow.org" :agenda t :required t)
    ("NSM-GTD/NsmOrg.org" :agenda t :required t)
    )
  (org-starter-def "~/.emacs.d"
    :files
    ("init.org" :key "i" :refile (:maxlevel . 5))
    ("nix.org" :key "x" :refile (:maxlevel . 5))
    )
  (org-starter-def "~/project/global-profile/global-doc/global-init.org")
  :bind
  (
   ("C-c e" . org-starter-select-file))
  ;; "C-c e" . org-starter-refile-by-key))
  )

(straight-use-package 'org-super-agenda)
(require 'org-super-agenda) 

;; org-agenda window dedication
(add-hook 'org-agenda-mode-hook
          (lambda ()
            (interactive)
            (set-window-dedicated-p (selected-window) 1)))

(defadvice org-agenda (around split-vertically activate)
  (let ((split-width-threshold 80))  ; or whatever width makes sense for you
    ad-do-it))

(require 'org-habit)
;; (setq org-agenda-time-grid
;;       '((daily today)
;;         ))
(setq 
 org-agenda-skip-scheduled-if-done t
 org-agenda-skip-deadline-if-done t
 org-agenda-include-deadlines t
 org-agenda-include-diary nil
 org-agenda-block-separator nil
 org-agenda-compact-blo0cks t
 org-agenda-start-with-log-mode t)



(setq org-agenda-custom-commands
      '(("z" "GtruN Agenda"
         ((agenda "" ((org-agenda-span 'day)
                      (org-super-agenda-groups
                       '((:habit t)
                         (:log t)
                         (:name "Today List"
                                :time-grid t
                                :date today
                                :todo "☞ TODO"
                                :scheduled today
                                :order 1)))))
          (alltodo "" ((org-agenda-overriding-header "")
                       (org-super-agenda-groups
                        '((:name "Next to do"
                                 :priority>= "B"
                                 :order 1)
                          (:name "Important"
                                 :todo "✰ Important"
                                 :order 6)
                          (:name "Due Today"
                                 :deadline today
                                 :order 2)
                          (:name "Due Soon"
                                 :deadline future
                                 :order 8)
                          (:name "Overdue"
                                 :deadline past
                                 :order 7)
                          (:name "Issues"
                                 :tag "Issue"
                                 :order 12)
                          (:name "Projects"
                                 :tag "Project"
                                 :order 14)
                          (:name "Emacs"
                                 :tag "Emacs"
                                 :order 13)
                          (:name "Research"
                                 :tag "Research"
                                 :order 15)
                          (:name "To read"
                                 :tag "BOOK"
                                 :order 30)
                          (:name "Waiting"
                                 :todo "⚑ WAITING"
                                 :order 20)
                          (:name "trivial"
                                 :priority<= "C"
                                 :todo ("SOMEDAY")
                                 :order 90)
                          (:discard (:tag ("Chore" "Routine" "Daily")))))))))

        ("b" . "BOOK")

        ("bb" "Search tags in todo, note, and archives"
         search "+{:book\\|books:}")

        ("bd" "BOOK TODO List"
         search "+{^\\*+\\s-+\\(STARTED\\|☞ TODO\\|WAITING\\)\\s-} +{book\\|books}")

        ("d" "ALL DONE OF TASKS"
         search "+{^\\*+\\s-+\\(DONE\\|✘ CANCELED\\)\\s-}")
        ))
;; WARNING double //
;;  +{^\*+\s-+\(TODO\|WAITING\):(book):\s-}  +(TODO\|WAITING\) +{:book\|books:}
;; +{^*+ -+(DONE|WAITING) -}

;; (defmacro eab/search-word (funcname name function &optional funargs)
;;   "Wrapper for search word interface."
;;   `(defun ,funcname (word)
;;      (interactive
;;       (list (read-string (concat ,name " word: ") (current-word))))
;;      (,function ,@funargs)))


;; (eab/search-word eab/org-agenda-search "agenda search" org-search-view (nil word))

(straight-use-package '(org-ql
                         :type git
                         :host github
                         :repo "alphapapa/org-ql"))

(eval-after-load "calendar" '(progn
  (define-key calendar-mode-map "<" 'jarfar/scroll-year-calendar-backward)
  (define-key calendar-mode-map ">" 'jarfar/scroll-year-calendar-forward) ))

(defun jarfar/year-calendar (&optional year)
  "Generate a one year calendar that can be scrolled by year in each direction.
This is a modification of:  http://homepage3.nifty.com/oatu/emacs/calendar.html
See also: https://stackoverflow.com/questions/9547912/emacs-calendar-show-more-than-3-months"
  (interactive)
  (require 'calendar)
  (let* (
      (current-year (number-to-string (nth 5 (decode-time (current-time)))))
      (month 0)
      (year (if year year (string-to-number (format-time-string "%Y" (current-time))))))
    (switch-to-buffer (get-buffer-create calendar-buffer))
    (when (not (eq major-mode 'calendar-mode))
      (calendar-mode))
    (setq displayed-month month)
    (setq displayed-year year)
    (setq buffer-read-only nil)
    (erase-buffer)
    ;; horizontal rows
    (dotimes (j 4)
      ;; vertical columns
      (dotimes (i 3)
        (calendar-generate-month
          (setq month (+ month 1))
          year
          ;; indentation / spacing between months
          (+ 5 (* 25 i))))
      (goto-char (point-max))
      (insert (make-string (- 10 (count-lines (point-min) (point-max))) ?\n))
      (widen)
      (goto-char (point-max))
      (narrow-to-region (point-max) (point-max)))
    (widen)
    (goto-char (point-min))
    (setq buffer-read-only t)))

(defun jarfar/scroll-year-calendar-forward (&optional arg event)
  "Scroll the yearly calendar by year in a forward direction."
  (interactive (list (prefix-numeric-value current-prefix-arg)
                     last-nonmenu-event))
  (unless arg (setq arg 0))
  (save-selected-window
    (if (setq event (event-start event)) (select-window (posn-window event)))
    (unless (zerop arg)
      (let* (
              (year (+ displayed-year arg)))
        (jarfar/year-calendar year)))
    (goto-char (point-min))
    (run-hooks 'calendar-move-hook)))

(defun jarfar/scroll-year-calendar-backward (&optional arg event)
  "Scroll the yearly calendar by year in a backward direction."
  (interactive (list (prefix-numeric-value current-prefix-arg)
                     last-nonmenu-event))
  (jarfar/scroll-year-calendar-forward (- (or arg 1)) event))


(defalias 'year-calendar #'jarfar/year-calendar)

(defun gtrun-org/org-insert-src-block (src-code-type)
  "Insert a `SRC-CODE-TYPE' type source code block in org-mode."
  (interactive
   (let ((src-code-types
          '("emacs-lisp" "python" "C" "sh" "java" "js" "clojure" "C++" "css"
            "calc" "asymptote" "dot" "gnuplot" "ledger" "lilypond" "mscgen"
            "octave" "oz" "plantuml" "R" "sass" "screen" "sql" "awk" "ditaa"
            "haskell" "latex" "lisp" "matlab" "ocaml" "org" "perl" "ruby"
            "scheme" "sqlite")))
     (list (ido-completing-read "Hack type: " src-code-types))))
  (progn
    (newline-and-indent)
    (insert (format "#+BEGIN_SRC %s :tangle yes\n" src-code-type))
    (newline-and-indent)
    (insert "#+END_SRC\n")
    (previous-line 2)
    (org-edit-src-code)))
(add-hook 'org-mime-html-hook
          (lambda ()
            (org-mime-change-element-style
             "pre" (format "color: %s; background-color: %s; padding: 0.5em;"
                           "#E6E1DC" "#232323"))))

(use-package org-bullets
  :straight t
  :hook (org-mode . org-bullets-mode)
  :config
;; 乾、坤、坎、離、震、巽、艮、兌 
(setq org-bullets-bullet-list '("☰" "☷" "☵" "☲"  "☳" "☴"  "☶"  "☱" ))
)

(use-package toc-org
  :after org
  :hook
  (org-mode . toc-org-enable))

(straight-use-package 'ox-hugo)
(require 'ox-hugo)

(use-package org-download
:straight t
:config
;; Drag-and-drop to `dired`
(add-hook 'dired-mode-hook 'org-download-enable)
(setq org-download-screenshot-file "~/Pictures/Monosnap/snap.png")
)

(use-package ox-latex
    :ensure nil
    :after ox
    :config
    (setq org-latex-listings t
          org-export-with-LaTeX-fragments t
    ;      org-latex-pdf-process (list "latexmk -shell-escape -bibtex -f -pdf %f")
))

(require 'ox)
(defun my-html-mark-tag (text backend info)
  "Transcode :blah: into <mark>blah</mark> in body text."
  (when (org-export-derived-backend-p backend 'html)
    (let ((text (replace-regexp-in-string "[^\\w]\\(:\\)[^\n\t\r]+\\(:\\)[^\\w]" "<mark>"  text nil nil 1 nil)))
      (replace-regexp-in-string "[^\\w]\\(<mark>\\)[^\n\t\r]+\\(:\\)[^\\w]" "</mark>" text nil nil 2 nil))))

(add-to-list 'org-export-filter-plain-text-functions 'my-html-mark-tag)

(defun my-html-mark-tag (text backend info)
  "Transcode :blah: into <mark>blah</mark> in body text."
  (when (org-export-derived-backend-p backend 'html)
    (let ((text (replace-regexp-in-string "[^\\w]\\(:\\)[^\n\t\r]+\\(:\\)[^\\w]" "<mark>"  text nil nil 1 nil)))
      (replace-regexp-in-string "[^\\w]\\(<mark>\\)[^\n\t\r]+\\(:\\)[^\\w]" "</mark>" text nil nil 2 nil))))

(add-to-list 'org-export-filter-plain-text-functions 'my-html-mark-tag)

(setq org-publish-project-alist
      '(("NSM"
	 :base-directory "~/org-notes/NSM-GTD"
	 :publishing-function org-html-publish-to-html
	 :publishing-directory "~/Dropbox/application/Bitcron/gtrun.bitcron.com/custom"
	 :include ["workflow.org"]
	 :exclude "Pattern.org"

	 )
	("init"
	 :base-directory "~/.emacs.d"
	 :publishing-function org-html-publish-to-html
	 :publishing-directory "~/Dropbox/application/Bitcron/gtrun.bitcron.com/custom"
	 :exclude "Pattern.org"
	 )
	("art"
	 :base-directory "~/org-notes/art"
	 :publishing-function org-html-publish-to-html
	 :publishing-directory "~/Dropbox/application/Bitcron/gtrun.bitcron.com/custom"
	 :exclude "Pattern.org"


	 )
	("course"
	 :base-directory "~/org-notes/course"
	 :publishing-function org-html-publish-to-html
	 :publishing-directory "~/Dropbox/application/Bitcron/gtrun.bitcron.com/custom"
	 :exclude "Pattern.org"
	 )
	))

(org-add-link-type "audio" #'ignore #'endless/export-audio-link)

(defun endless/export-audio-link (path desc format)
  "Export org audio links to hmtl."
  (cl-case format
    (html (format
	   "<audio preload=\"auto\"> <source src=\"https://www.gtrun.org/music/%s\">%s</audio>"
	   path (or desc "")))

    ;; README: hugo music file path
    (md (format
	 "<audio class=\"wp-audio-shortcode\"  loop=\"1\"  preload=\"auto\" style=\"width: 100%%;\" controls> <source src=\"https://www.gtrun.org/music/%s\">%s</audio>"
	 path (or desc "")))
    (latex (format "(HOW DO I EXPORT AUDIO TO LATEX? \"%s\")" path))))

(straight-use-package 'htmlize)
(require 'htmlize)

(straight-use-package 'posframe)
(require 'posframe)

(straight-use-package 'pyim)
(require 'pyim)
(require 'pyim-basedict) ; 拼音词库设置，五笔用户 *不需要* 此行设置
(pyim-basedict-enable)   ; 拼音词库，五笔用户 *不需要* 此行设置
(setq default-input-method "pyim")
;; (setq pyim-default-scheme 'wubi)
;; (setq pyim-default-scheme 'quanpin)

;; 使用 pupup-el 来绘制选词框
(if (>= emacs-major-version 26)
    (setq pyim-page-tooltip 'child-frame)
  (setq pyim-page-tooltip 'popup))

;; 选词框显示 10 个候选词
(setq pyim-page-length 5)

(setq-default pyim-english-input-switch-functions
              '(pyim-probe-org-structure-template))

(setq-default pyim-punctuation-half-width-functions
              '(pyim-probe-punctuation-line-beginning
                pyim-probe-punctuation-after-punctuation))



(global-set-key (kbd "s-;") 'pyim-convert-string-at-point)
(define-key pyim-mode-map (kbd "<tab>") 'pyim-page-next-page)
(define-key pyim-mode-map (kbd "C-j") 'pyim-page-next-page)
(define-key pyim-mode-map (kbd "C-k") 'pyim-page-previous-page)
(define-key pyim-mode-map (kbd "<escape>") 'pyim-quit-clear)

;; (add-hook 'toggle-input-method #'xah-fly-insert-mode-activate)
(setq pyim-dicts
      `((:name "sougou-shiji" :file ,(expand-file-name "pyim/shiji.pyim" user-emacs-directory))
        (:name "sougou-shijin" :file ,(expand-file-name "pyim/shijin.pyim" user-emacs-directory))))

(use-package ace-pinyin
:straight t
:config
(setq ace-pinyin-simplified-chinese-only-p nil)
(setq ace-pinyin-use-avy t)
(ace-pinyin-global-mode +1)
)

(use-package pangu-spacing
  :straight t
  :config
  (global-pangu-spacing-mode 1)
  (add-hook 'org-mode-hook
            '(lambda ()
               (set (make-local-variable 'pangu-spacing-real-insert-separtor) t))))

(straight-use-package 'pinyinlib)
  (require 'pinyinlib)

  (defun re-builder-extended-pattern (str)
    (let* ((len (length str)))
      (cond
       ;; do nothing
       ((<= (length str) 0))

       ;; If the first charater of input in ivy is ":",
       ;; remaining input is converted into Chinese pinyin regex.
       ((string= (substring str 0 1) ":")
        (setq str (pinyinlib-build-regexp-string (substring str 1 len) t)))

       ;; If the first charater of input in ivy is "/",
       ;; remaining input is converted to pattrn to search camel case word
       ((string= (substring str 0 1) "/")
        (let* ((rlt "")
               (i 0)
               (subs (substring str 1 len))
               c)
          (when (> len 2)
            (setq subs (upcase subs))
            (while (< i (length subs))
              (setq c (elt subs i))
              (setq rlt (concat rlt (cond
                                     ((and (< c ?a) (> c ?z) (< c ?A) (> c ?Z))
                                      (format "%c" c))
                                     (t
                                      (concat (if (= i 0) (format "[%c%c]" (+ c 32) c)
                                                (format "%c" c))
                                              "[a-z]+")))))
              (setq i (1+ i))))
          (setq str rlt))))
      (ivy--regex-plus str)))


  (eval-after-load 'ivy 
    '(progn
       ;; better performance on everything (especially windows), ivy-0.10.0 required
       ;; @see https://github.com/abo-abo/swiper/issues/1218
       (setq ivy-dynamic-exhibit-delay-ms 250)

       ;; Press C-p and Enter to select current input as candidate
       ;; https://oremacs.com/2017/11/30/ivy-0.10.0/
       (setq ivy-use-selectable-prompt t)

       (setq ivy-re-builders-alist
             '((t . re-builder-extended-pattern)))
       ;; set actions when running C-x b
       ;; replace "frame" with window to open in new window
       (ivy-set-actions
        'ivy-switch-buffer-by-pinyin
        '(("j" switch-to-buffer-other-frame "other frame")
          ("k" kill-buffer "kill")
          ("r" ivy--rename-buffer-action "rename")))))
(with-eval-after-load "swiper-isearch"
 (setq ivy-re-builders-alist
        '((t . re-builder-extended-pattern)
          (t . ivy-prescient-re-builder))))

(use-package eshell
  :ensure nil
  :hook
  (eshell-mode . (lambda () (eshell/export "NODE_NO_READLINE=1")))
  (eshell-exit . (lambda () (setq esh-prompt-num 0)))

  :config

  ;; If I ever want my own eshell/foo commands overwrite real commands ...
  (setq eshell-prefer-lisp-functions t)
  (add-to-list 'eshell-modules-list 'eshell-tramp)

  (setq eshell-prefer-lisp-variables t)

  (setq password-cache t) ; enable password caching
  (setq password-cache-expiry 3600) ; for one hour (time in secs)


  (defun clipboard/set (astring)
    "Copy a string to clipboard"
    (with-temp-buffer
      (insert astring)
      (clipboard-kill-region (point-min) (point-max))))

  (defun eshell/copy-pwd ()
    "Copy current directory to clipboard "
    (clipboard/set (eshell/pwd)))

  (defun eshell/copy-fpath (fname)
    "Copy file name with full path to clipboard "
    (let ((fpath (concat (eshell/pwd) "/" fname)))
      (clipboard/set fpath)
      (concat "Copied path: " fpath)))
  )

(straight-use-package '(aweshell
                        :type git
                        :host github
                        :repo "manateelazycat/aweshell"))
(require 'aweshell)

(use-package magit
  :straight t;(magit :type git :host github :repo "magit/magit")
  :commands (magit)
 ; :hook
 ; (magit-mode . (lambda () (local-set-key (kbd "o") 'magit-open-repo)))

  :config

  ;; Ignore recent commit
  (setq magit-status-sections-hook
        '(magit-insert-status-headers
          magit-insert-merge-log
          magit-insert-rebase-sequence
          magit-insert-am-sequence
          magit-insert-sequencer-sequence
          magit-insert-bisect-output
          magit-insert-bisect-rest
          magit-insert-bisect-log
          magit-insert-untracked-files
          magit-insert-unstaged-changes
          magit-insert-staged-changes
          magit-insert-stashes
          magit-insert-unpulled-from-upstream
          magit-insert-unpulled-from-pushremote
          magit-insert-unpushed-to-upstream
          magit-insert-unpushed-to-pushremote))


  ;; Update visualization
  (setq pretty-magit-alist nil
        pretty-magit-prompt nil)

  (defmacro pretty-magit (WORD ICON PROPS &optional NO-PROMPT?)
    "Replace sanitized WORD with ICON, PROPS and by default add to prompts."
    `(prog1
         (add-to-list 'pretty-magit-alist
                      (list (rx bow (group ,WORD (eval (if ,NO-PROMPT? "" ":"))))
                            ,ICON ',PROPS))
       (unless ,NO-PROMPT?
         (add-to-list 'pretty-magit-prompt (concat ,WORD ": ")))))

  ;; Operations
  (pretty-magit "add"   ? (:foreground "#375E97" :height 1.2) pretty-magit-prompt)
  (pretty-magit "fix"   ? (:foreground "#FB6542" :height 1.2) pretty-magit-prompt)
  (pretty-magit "clean" ? (:foreground "#FFBB00" :height 1.2) pretty-magit-prompt)
  (pretty-magit "doc."  ? (:foreground "#3F681C" :height 1.2) pretty-magit-prompt)

  ;; Meta information
  (pretty-magit "master"  ? (:box nil :height 1.2) t)
  (pretty-magit "origin"  ? (:box nil :height 1.2) t)
  (pretty-magit "upstream"  ? (:box nil :height 1.2) t)

  (defun add-magit-faces ()
    "Add face properties and compose symbols for buffer from pretty-magit."
    (interactive)
    (with-silent-modifications
      (--each pretty-magit-alist
        (-let (((rgx icon props) it))
          (save-excursion
            (goto-char (point-min))
            (while (search-forward-regexp rgx nil t)
              (compose-region
               (match-beginning 1) (match-end 1) icon)
              (when props
                (add-face-text-property
                 (match-beginning 1) (match-end 1) props))))))))

  (advice-add 'magit-status :after 'add-magit-faces)
  (advice-add 'magit-refresh-buffer :after 'add-magit-faces)


  ;; Opening repo externally
  (defun parse-url (url)
    "convert a git remote location as a HTTP URL"
    (if (string-match "^http" url)
        url
      (replace-regexp-in-string "\\(.*\\)@\\(.*\\):\\(.*\\)\\(\\.git?\\)"
                                "https://\\2/\\3"
                                url)))
  (defun magit-open-repo ()
    "open remote repo URL"
    (interactive)
    (let ((url (magit-get "remote" "origin" "url")))
      (progn
        (browse-url (parse-url url))
        (message "opening repo %s" url))))

  (setq magit-display-buffer-function #'+magit-display-buffer)
  (defun +magit-display-buffer (buffer)
    "Marries `magit-display-buffer-fullcolumn-most-v1' with
`magit-display-buffer-same-window-except-diff-v1', except:

1. Magit sub-buffers that aren't spawned from a status screen are opened as
   popups.
2. The status screen isn't buried when viewing diffs or logs from the status
   screen."
    (let ((buffer-mode (buffer-local-value 'major-mode buffer)))
      (display-buffer
       buffer (cond
               ;; If opened from an eshell window or popup, use the same window.
               ((or (derived-mode-p 'eshell-mode)
                    (eq (window-dedicated-p) 'side))
                '(display-buffer-same-window))
               ;; Open target buffers below the current one (we want previous
               ;; magit windows to be visible; especially magit-status).
               ((or (bound-and-true-p git-commit-mode)
                    (derived-mode-p 'magit-mode))
                (let ((size (if (eq buffer-mode 'magit-process-mode)
                                0.35
                              0.7)))
                  `(display-buffer-below-selected
                    . ((window-height . ,(truncate (* (window-height) size)))))))
               ;; log/stash/process buffers, unless opened from a magit-status
               ;; window, should be opened in popups.
               ((memq buffer-mode '(magit-process-mode
                                    magit-log-mode
                                    magit-stash-mode))
                '(display-buffer-below-selected))
               ;; Last resort: use current window
               ('(display-buffer-same-window))))))


(defun magit-remove-git-lock-file ()
  "Remove git's index lock file, if it exists."
  (interactive)
  (let ((base (magit-toplevel)))
    (delete-file (concat base "/.git/index.lock"))))

  )

(use-package magit-todos
:straight t
:after magit
:hook
(magit-mode . magit-todos-mode)
:config
(setq magit-todos-exclude-globs '("nixpkgs/*"))
)

(use-package magithub
  :straight t
  :after (:all magit)
  :config
  (magithub-feature-autoinject t)
  (setq magithub-github-hosts '("github.enterprise.domain/api/v3"))
  (setq magithub-clone-default-directory "~/tmp"))

(straight-use-package 'w3m)
(require 'w3m)

(straight-use-package 'helpful)

(straight-use-package 'info-buffer)
;;(straight-use-package 'info+)

(defhydra hydra-projectile-other-window (:color teal)
  "projectile-other-window"
  ("f"  projectile-find-file-other-window        "file")
  ("g"  projectile-find-file-dwim-other-window   "file dwim")
  ("d"  projectile-find-dir-other-window         "dir")
  ("b"  projectile-switch-to-buffer-other-window "buffer")
  ("q"  nil                                      "cancel" :color blue))

(defhydra hydra-projectile (:color teal :hint nil)
  "
     PROJECTILE: %(projectile-project-root)

     Find File            Search/Tags          Buffers                Cache
------------------------------------------------------------------------------------------
_s-f_: file            _a_: ag                _i_: Ibuffer           _c_: cache clear
 _ff_: file dwim       _g_: update gtags      _b_: switch to buffer  _x_: remove known project
 _fd_: file curr dir   _o_: multi-occur     _s-k_: Kill all buffers  _X_: cleanup non-existing
  _r_: recent file                                               ^^^^_z_: cache current
  _d_: dir

"
  ("<ESC>" nil "quit")
  ("<" hydra-project/body "back")
  ("a"   projectile-ag)
  ("b"   projectile-switch-to-buffer)
  ("c"   projectile-invalidate-cache)
  ("d"   projectile-find-dir)
  ("s-f" projectile-find-file)
  ("ff"  projectile-find-file-dwim)
  ("fd"  projectile-find-file-in-directory)
  ("g"   ggtags-update-tags)
  ("s-g" ggtags-update-tags)
  ("i"   projectile-ibuffer)
  ("K"   projectile-kill-buffers)
  ("s-k" projectile-kill-buffers)
  ("m"   projectile-multi-occur)
  ("o"   projectile-multi-occur)
  ("s-p" projectile-switch-project "switch project")
  ("p"   projectile-switch-project)
  ("s"   projectile-switch-project)
  ("r"   projectile-recentf)
  ("x"   projectile-remove-known-project)
  ("X"   projectile-cleanup-known-projects)
  ("z"   projectile-cache-current-file)
  ("`"   hydra-projectile-other-window/body "other window" :color blue)
  ("q"   nil "cancel" :color blue))

(defhydra hydra-magit (:color teal :hint nil)
  "
      Magit: %(magit-get \"remote\" \"origin\" \"url\")

 Status/Info      Remote          Operations
------------------------------------------------------------------------------------------
_s_: Status      _f_: Pull       _c_: commit
_l_: Log all     _p_: Push
_d_: Diff
_t_: timeline
"
  ("<ESC>" nil "quit")
  ("<" hydra-project/body "back")
  ("f" magit-pull-branch)
  ("p" magit-push-other)
  ("c" magit-commit-create)
  ("d" magit-diff-range)
  ("l" magit-log-all)
  ("s" magit-status)
  ("t" git-timeline)
  ("q"   nil "cancel" :color blue))

(defhydra hydra-flycheck (:pre (progn (setq hydra-lv t) (flycheck-list-errors))
                               :post (progn (setq hydra-lv nil) (quit-windows-on "*Flycheck errors*"))
                               :color teal
                               :hint nil)
  "Errors"
  ("f"  flycheck-error-list-set-filter                            "Filter")
  ("j"  flycheck-next-error                                       "Next")
  ("k"  flycheck-previous-error                                   "Previous")
  ("gg" flycheck-first-error                                      "First")
  ("G"  (progn (goto-char (point-max)) (flycheck-previous-error)) "Last")
  ("<" hydra-project/body "back")
  ("q"   nil "cancel" :color blue))


(defhydra hydra-project (:color teal :hint nil)
  "
     Project/Source management

 Projects              Version control        On-the-fly
------------------------------------------------------------------------------------------
_d_: dash projects     _m_: magit             _f_: fixme listing
_p_: projectile        _t_: travis status     _F_: flycheck

"
  ("<ESC>" nil "quit")
  ("d"   org-dashboard-display)
  ("p"   hydra-projectile/body)
  ("f"   fic-view-listing)
  ("F"   hydra-flycheck/body)
  ("m"   hydra-magit/body)
  ("t"   show-my-travis-projects)
  ("q"   nil "cancel" :color blue))
(global-set-key (kbd "<f4>") 'hydra-project/body)

(define-key emacs-lisp-mode-map (kbd "C-c C-c") 'eval-buffer)

(use-package bug-hunter
:straight (elisp-bug-hunter :type git
                            :host github
                            :repo "Malabarba/elisp-bug-hunter"))

(setq-default default-tab-width 4)
;; 禁止响铃
(setq ring-bell-function 'ignore)
;; 设置光标形状
;;(setq-default cursor-type '(bar . 3))
;; 高亮当前行
(global-hl-line-mode t)

;; (setq org-hide-block-startup t)

;(remove-hook 'find-file-hooks 'vc-find-file-hook)

(use-package eww
:ensure nil
:disabled t)

(use-package macos
  :load-path "./setup"
  :if (memq window-system '(mac ns))
  )

(use-package linux
:load-path "./setup"
:if (eq system-type 'gnu/linux)
)

(use-package undo-propose
       :straight t
       :disabled t
       :commands (undo-propose)
       :bind ("C-x u" . undo-propose))


(straight-use-package 'undo-tree)
(global-undo-tree-mode 1)

;;TODO: undo-tree-auto-save-history

(setq highlight-indent-guides-auto-enabled nil)

        (custom-set-faces
         '(ivy-current-match ((t (:background "grey70" :foreground "DarkOrchid3"))))
      '(ivy-highlight-face             ((t (:background nil :foreground nil :underline unspecified :weight unspecified))))
         '(ivy-minibuffer-match-face-1 ((t (:underline t :foreground "LightGreen" :inherit bold))))
         '(ivy-minibuffer-match-face-2 ((t (:underline t :foreground "LightGreen"))))
         '(ivy-minibuffer-match-face-3 ((t (:underline t :foreground "LightGreen"))))
         '(ivy-minibuffer-match-face-4 ((t (:underline t :foreground "LightGreen"))))
         '(swiper-match-face-1 ((t (:underline t :foreground "LightGreen" :inherit bold))))
         '(swiper-line-face ((t (:background "grey70" :foreground "DarkOrchid3"))))
         '(centaur-tabs-close-selected((t ( :foreground "DarkGray"))))
         '(centaur-tabs-modified-marker-selected ((t ( :foreground "yellow2"))))
         '(centaur-tabs-selected ((t ( :foreground "LimeGreen"))))
         '(centaur-tabs-unselected ((t ( :foreground "DarkSlateGray4"))))
         '(highlight-indent-guides-odd-face ((t ( :background "IndianRed"))))
         '(highlight-indent-guides-even-face ((t ( :background "DarkSeaGreen4"))))
;;         '(highlight-indent-guides-character-face ((t ( :background "DarkSeaGreen4"))))


           ) 
        (setq ivy-format-function 'ivy-format-function-line)

(defun gtrun-open-in-terminal ()
  "Open the current dir in a new terminal window.
URL `http://ergoemacs.org/emacs/emacs_dired_open_file_in_ext_apps.html'
Version 2017-10-09"
  (interactive)
  (cond
   ((string-equal system-type "windows-nt")
    (message "Microsoft Windows not supported. File a bug report or pull request."))
   ((string-equal system-type "darwin")
    (let ((process-connection-type nil))
      (start-process "" nil "/Applications/iTerm.app/Contents/MacOS/iTerm2" default-directory)))
   ((string-equal system-type "gnu/linux")
    (let ((process-connection-type nil))
      (start-process "" nil "termite"
                     (concat "--directory=" default-directory))))))

(defun edit-current-file-as-root ()
  "Edit the file that is associated with the current buffer as root"
  (interactive)
  (if (buffer-file-name)
      (find-file (concat "/sudo:localhost:" (buffer-file-name)))
    (message "Current buffer does not have an associated file.")))

(use-package auto-minor-mode
   :straight t
   )

(use-package snapshot-timemachine
  :straight t
  :init

  ;; Default Backup directory

;; Default Backup directory
  (defvar backup-directory "~/.emacs.d/var/backups/")
  (setq backup-directory-alist `((".*" . ,backup-directory)))

  (when (not (file-exists-p backup-directory))
    (make-directory backup-directory t))

  ;; (setq backup-directory-alist `((".*" ,(no-littering-expand-var-file-name "backup/"))))

  ;; (when (not (file-exists-p no-littering-var-directory))
  ;;   (make-directory no-littering-var-directory t))

  ;; Auto-save

  (setq auto-save-file-name-transforms
        `((".*" ,(no-littering-expand-var-file-name "auto-save/")t)))

  (when (not (file-exists-p no-littering-var-directory))
    (make-directory auto-save-directory t))

  ;; Tramp backup
  (setq tramp-backup-directory-alist `((".*" . ,(no-littering-expand-var-file-name "tramp-backups/"))))

  (when (not (file-exists-p no-littering-var-directory))
    (make-directory no-littering-var-directory t))

  (setq make-backup-files t               ; backup of a file the first time it is saved.
        backup-by-copying t               ; don't clobber symlinks
        version-control t                 ; version numbers for backup files
        delete-old-versions t             ; delete excess backup files silently
        delete-by-moving-to-trash t
        kept-old-versions 6               ; oldest versions to keep when a new numbered backup is made (default: 2)
        kept-new-versions 9               ; newest versions to keep when a new numbered backup is made (default: 2)
        auto-save-default t               ; auto-save every buffer that visits a file
        auto-save-timeout 20              ; number of seconds idle time before auto-save (default: 30)
        auto-save-interval 200            ; number of keystrokes between auto-saves (default: 300)
        )

  :config

  (defun snapshot-timemachine-backup-finder (file)
    "Find snapshots of FILE in rsnapshot backups."
    (let* ((file (expand-file-name file))
           (file-adapted (replace-regexp-in-string "/" "!" file))
           (backup-files(directory-files backup-directory t (format "%s.*" file-adapted))))
      (seq-map-indexed (lambda (backup-file index)
                         (make-snapshot :id index
                                        :name (format "%d" index)
                                        :file backup-file
                                        :date (nth 5 (file-attributes backup-file))))
                       backup-files)))

  (setq snapshot-timemachine-snapshot-finder #'snapshot-timemachine-backup-finder))

(define-minor-mode sensitive-mode
  "For sensitive files like password lists.
It disables backup creation and auto saving.

With no argument, this command toggles the mode.
Non-null prefix argument turns on the mode.
Null prefix argument turns off the mode."
  ;; The initial value.
  nil
  ;; The indicator for the mode line.
  " Sensitive"
  ;; The minor mode bindings.
  nil
  (if (symbol-value sensitive-mode)
      (progn
        ;; disable backups
        (set (make-local-variable 'backup-inhibited) t)
        ;; disable auto-save
        (if auto-save-default
            (auto-save-mode -1)))
                                        ;resort to default value of backup-inhibited
    (kill-local-variable 'backup-inhibited)
                                        ;resort to default auto save setting
    (if auto-save-default
        (auto-save-mode 1))))


(add-to-list 'auto-minor-mode-alist '("\\.git/.*\\'" . sensitive-mode))
(add-to-list 'auto-minor-mode-alist '("emacs\\.d/.*\\'" . sensitive-mode))
(add-to-list 'auto-minor-mode-alist '("emacs\\.d/emms/.*\\'" . sensitive-mode))
(add-to-list 'auto-minor-mode-alist '("Calendars/.*.org\\'" . sensitive-mode))
(add-to-list 'auto-minor-mode-alist '("\\.gpg\\'" . sensitive-mode))

(setq system-time-locale "en_US.utf8")
(prefer-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)

(use-package goto-line-preview
  :straight t
  :commands (goto-line-preview)
  :bind
  (("M-g" . goto-line-preview)))

(ignore-errors
    (dotimes (i 50)
      (windmove-down)))

(setq ad-redefinition-action 'accept)

;(setq kill-buffer-query-functions (delq 'process-kill-buffer-query-function kill-buffer-query-functions))
(setq kill-buffer-query-functions nil)
(setq org-adapt-indentation nil)
