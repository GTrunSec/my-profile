(straight-use-package 'xah-fly-keys)
 (require 'xah-fly-keys)

 (add-hook 'xah-fly-command-mode-activate-hook
           (lambda ()
             (setq xah-fly-insert-state-q nil)))
 ;; automatic save buffer when switching to command mode
 ;; (add-hook 'xah-fly-command-mode-activate 'xah-fly-save-buffer-if-file)

 ;;(xah-fly-keys-set-layout "qwerty") 

 (xah-fly-keys 1)

(require 'xah-fly-keys)

(xah-fly--define-keys
 (define-prefix-command 'xah-fly-leader-key-map)
 '(
   ("2" . org-keymap)
   ("8" . git-keymap)
   ("fr" . counsel-recentf)
   ;;("<tab>" . spacemacs/alternate-buffer)
   ("ff" . counsel-fd-file-jump)
   ("fj" . counsel-fd-dired-jump)
   ("RET" . helm-bookmarks)
   ;; treemacs
   ("tt" . treemacs-toggle)
   ("tf" . treemacs-fine-file)
   ;; helm
   ("bb" . switch-to-buffer)
   ;; isearch
   ("y" . xah-search-current-word)
   ;; search
   ("sa" . counsel-ag)
   ("sr" . counsel-rg)
   ;; imenu
   ("il" . imenu-list-smart-toggle)
   ))

(xah-fly--define-keys
 ;; create a keymap my-keymap
 (define-prefix-command 'git-keymap)
 '(
   ("d" . magit-remove-git-lock-file)
   ("r" . magit-reset-hard)
   ;;
   ))
(xah-fly--define-keys
 ;; create a keymap org-keymap
 (define-prefix-command 'org-keymap)
 '(
   ("i" . org-clock-in)
   ("o" . org-clock-out)
   ("l" . org-clcok-in-last)
   ("r" . org-starter-refile-by-key)
   ("s" .org-starter-select-file-other-window)
   ;;
   ))

;; edit
(define-key xah-fly-key-map (kbd "C-a") 'beginning-of-visual-line)
(define-key xah-fly-key-map (kbd "C-0") 'delete-region)
(define-key xah-fly-key-map (kbd "C-n") 'next-line)
(define-key xah-fly-key-map (kbd "C-;") 'maple-iedit-match-all)


;; org-mode
(define-key xah-fly-key-map (kbd "C-c l") 'org-mac-grab-link)
(define-key xah-fly-key-map (kbd "C-c a") 'org-agenda)
(define-key xah-fly-key-map (kbd "C-c w") 'helm-deft)

;; iseach
(define-key xah-fly-key-map (kbd "C-s") 'swiper-isearch)


;; scrolling
(define-key xah-fly-key-map (kbd "C-v") 'scroll-up-command)

(defun xah-fly-command-mode-init ()
  "Set command mode keys.
               Version 2017-01-21"
  (interactive)
  (xah-fly--define-keys
   xah-fly-key-map
   '(
     ;; IMPORTANT, These keys are all dvorak keys
     ("~"	.	nil)
     (":"	.	nil)

     ("SPC" . xah-fly-leader-key-map)
     ("2" . org-agenda)
     ("3". helm-bookmarks)
     ("4". adq/helm-bm-list-all)
     ("q" . quit-window)
     ("a" . counsel-M-x)
     ("i" . previous-line)
     ("k" . next-line )
     ("b" . backward-word)
     ("h" . forward-word)
     ("l" . backward-char)
     ("j" . forward-char)
     ("f" . xah-fly-insert-mode-activate)
     ("[" . xah-backward-punct )
     ("]" . xah-forward-punct)
     ("gt"	.	vinegar/jump-to-bottom)
     ("gg"	.	beginning-of-buffer)
     ("y" . undo)
     ("v" . xah-paste-or-paste-previous)
     ("c" . xah-copy-line-or-region)
     ("x" . xah-cut-line-or-region)
     ("t" . set-mark-command)
     ("6" . xah-select-block)
     ("7" . xah-select-line)
     ("8" . xah-extend-selection)
     ("9" . xah-select-text-in-quote)
     ("0" . xah-pop-local-mark-ring)
     ("n" . isearch-forward)
     ))
  (define-key xah-fly-key-map (kbd ".") 'gtrun-xah-dot-fly-key)
  (define-key xah-fly-key-map (kbd "p") 'gtrun-xah-fly-key)
  (define-key xah-fly-key-map (kbd "M-<SPC>") 'xah-fly-command-mode-activate)

  (define-key xah-fly-key-map (kbd "-") 'gtrun-xah-minus-fly-key)
  (define-key xah-fly-key-map (kbd "/") 'gtrun-xah-slash-fly-key)
  (define-key xah-fly-key-map (kbd ",") 'gtrun-xah-comma-fly-key)
  (define-key xah-fly-key-map (kbd "'") 'gtrun-xah-apostrophe-fly-key)
  (define-key xah-fly-key-map (kbd ";") 'gtrun-xah-semicolon-fly-key)
  (define-key xah-fly-key-map (kbd "=") 'gtrun-xah-equality-fly-key)

  )

(defun gtrun-xah-dot-fly-key ()
  "key `.'"
  (interactive)
  (cond
   ;; ((eq major-mode 'dired-mode) (call-interactively 'd))
   ((eq major-mode 'dired-mode) (call-interactively 'hydra-dired/body))
   ((eq major-mode 'w3m-mode) (call-interactively 'scroll-up))
   ((eq major-mode 'org-mode) (call-interactively 'org-edit-src-code))
   (t nil)))

(defun gtrun-xah-comma-fly-key ()
  "key `,'"
  (interactive)
  (cond
   ;; ((eq major-mode 'dired-mode) (call-interactively 'd))
   ((eq major-mode 'w3m-mode) (call-interactively 'scroll-down))
   (t nil)))

(defun gtrun-xah-slash-fly-key ()
  "key `/'"
  (interactive)
  (cond
   ;; ((eq major-mode 'dired-mode) (call-interactively 'd))
   ((eq major-mode 'dired-mode) (call-interactively 'vinegar/dired-diff))
   ((eq major-mode 'w3m-mode) (call-interactively 'w3m-bookmark-add-current-url))
   ((eq major-mode 'org-agenda-mode) (call-interactively 'org-agenda-filter-by-tag))

   (t nil)))

(defun gtrun-xah-semicolon-fly-key ()
  "key `;'"
  (interactive)
  (cond
   ;; ((eq major-mode 'dired-mode) (call-interactively 'd))

   (t nil)))

(defun gtrun-xah-apostrophe-fly-key ()
  "key `''"
  (interactive)
  (cond
   ;; ((eq major-mode 'dired-mode) (call-interactively 'd))

   (t nil)))
(defun gtrun-xah-equality-fly-key ()
  "key `='"
  (interactive)
  (cond
   ;; ((eq major-mode 'dired-mode) (call-interactively 'd))
   (t nil)))


(defun gtrun-xah-fly-key ()
  "key `p'"
  (interactive)
  (cond
   ;; ((eq major-mode 'dired-mode) (call-interactively 'd))
   ((eq major-mode 'dired-mode) (call-interactively 'xah-open-in-external-app))
   (t nil)))


(defun gtrun-xah-minus-fly-key ()
  "key `-'"
  (interactive)
  (cond
   ;; ((eq major-mode 'dired-mode) (call-interactively 'd))
   ((eq major-mode 'dired-mode) (call-interactively 'vinegar/up-directory))
   (t nil)))



(provide 'xah-fly-key-normal)
