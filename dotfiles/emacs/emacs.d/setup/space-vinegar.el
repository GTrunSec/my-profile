(defun vinegar/up-directory (&optional other-window)
  "Run Dired on parent directory of current directory."
  (interactive "P")
  (let* ((dir (dired-current-directory))
         (orig (current-buffer))
         (up (file-name-directory (directory-file-name dir))))
    (or (dired-goto-file (directory-file-name dir))
        ;; Only try dired-goto-subdir if buffer has more than one dir.
        (and (cdr dired-subdir-alist)
             (dired-goto-subdir up))
        (progn
          (kill-buffer orig)
          (dired up)
          (dired-goto-file dir)))))



(defun vinegar/dotfiles-toggle ()
  "Show/hide dot-files"
  (interactive)
  (when (equal major-mode 'dired-mode)
    (if (or (not (boundp 'dired-dotfiles-show-p)) dired-dotfiles-show-p) ; if currently showing
        (progn
          (set (make-local-variable 'dired-dotfiles-show-p) nil)
          (message "h")
          (dired-mark-files-regexp "^\\\.")
          (dired-do-kill-lines))
      (progn (revert-buffer) ; otherwise just revert to re-show
             (set (make-local-variable 'dired-dotfiles-show-p) t)))))

(defun vinegar/back-to-top ()
  "Move to first file"
  (interactive)
  (beginning-of-buffer)
  (dired-next-line 1))

(defun vinegar/jump-to-bottom ()
  "Move to last file"
  (interactive)
  (end-of-buffer)
  (dired-next-line -1))

(defun vinegar/move-up ()		
  "Move to previous file"
  (interactive)
  (dired-previous-line 1)
  (if (bobp)
      (dired-next-line 1)))

(defun vinegar/move-down ()
  "Move to next file"
  (interactive)
  (dired-next-line 1)
  (if (eobp)
      (dired-next-line -1)))


(provide 'space-vinegar)
